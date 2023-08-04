package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	/*============
	 * 자바빈 초기화
	 *============*/
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	/*============
	 * 회원가입
	 *============*/
	//아이디 중복 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String,String> confirmId(@RequestParam String id){
		log.debug("<<아이디 중복 체크>> : "+id);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO member = memberService.selectCheckMember(id);
		log.debug("<<member>> : " + member);
		if(member!=null) {//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {//아이디 미중복
			if(!Pattern.matches("^[A-Za-z0-9]{4,12}$", id)) {
				//패턴 불일치
				mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		
		return mapAjax;
	}
	
	//회원가입 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		return "memberRegister";
	}
	
	//회원가입 처리
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model) {
		//유효성 체크 결과 요류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원가입
		memberService.insertMember(memberVO);
		
		model.addAttribute("accessMsg","회원가입이 완료되었습니다.");
		
		return "common/notice";
	}
	
	/*============
	 * 회원로그인
	 *============*/
	//로그인 폼
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "memberLogin";
	}
	
	//로그인 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model, HttpServletResponse response) {
		//id와 passwd 필드만 유효성 체크 후 결과에 오류가 있으면 폼 호출
		if(result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return formLogin();
		}
		
		//로그인체크(id,비밀번호 일치 여부 체크)
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getId());
			boolean check = false;
			
			if(member!=null) {
				//비밀번호 일치여부 체크
				check = member.isCheckedPassword(memberVO.getPasswd());
			}
			
			if(check) {//인증 성공
				// ===자동 로그인 체크 시작===
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");
				if(autoLogin) {//자동 로그인 체크를 한 경우
					String au_id = member.getAu_id();
					if(au_id==null) {
						//자동로그인 체크 식별값 생성
						au_id = UUID.randomUUID().toString();
						log.debug("<<au_id>> : "+au_id);
						memberService.updateAu_id(au_id, member.getMem_num());
					}
					
					//쿠키 생성
					Cookie auto_cookie = new Cookie("au-log",au_id);
					auto_cookie.setMaxAge(60*60*24*7);//쿠키 유효시간
					auto_cookie.setPath("/");//루트 밑으로 내려오면 다 사용할 수 있게
					
					response.addCookie(auto_cookie);		
				}
				// ===자동 로그인 체크 끝===
				
				
				//인증 성공, 로그인 처리
				session.setAttribute("user", member);
				
				log.debug("<<인증성공>> : ");
				log.debug("<<id>> : " + member.getId());
				log.debug("<<auth>> : " + member.getAuth());
				log.debug("<<au_id>> : "+member.getAu_id());
				
				if(member.getAuth() == 9) {//관리자인 경우
					return "redirect:/main/admin.do";//관리자 전용페이지로 이동
				}else {
					return "redirect:/main/main.do";
				}
			}
			
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			//인증 실패로 로그인 폼 호출
			if(member!=null && member.getAuth()==1) {
				//정지회원 메세지 표시
				result.reject("noAutority");
			}else {
				result.reject("invalidIdOrPassword");
			}
			
			log.debug("<<인증 실페>>");
			return formLogin();
		}

	}
	
	/*============
	 * 로그아웃
	 *============*/
	@RequestMapping("/member/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) {
		//로그아웃
		session.invalidate();
		
		// ===자동 로그인 해제 시작===
		//클라이언트 쿠키 처리
		Cookie auto_cookie = new Cookie("au-log", "");
		auto_cookie.setMaxAge(0);//쿠키의 삭제(기간 만료시켜 버림)
		auto_cookie.setPath("/");

		response.addCookie(auto_cookie);
		// ===자동 로그인 해제 끝===
		
		
		return "redirect:/main/main.do";
	}
	
	/*============
	 * my페이지
	 *============*/
	@RequestMapping("/member/myPage.do")
	public String myPage(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원 정보 반환
		MemberVO member = memberService.selectMember(user.getMem_num());
		
		//회원정보
		model.addAttribute("member",member);//member라는 이름으로 member를 넣어줌
		
		return "myPage";
	}
	
	/*============
	 * 프로필 사진 출력
	 *============*/
	//프로필 사진 출력(로그인용)
	@RequestMapping("/member/photoView.do")
	public String getProfile(HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<photoView>> : "+user);
		
		if(user==null) {//로그인이 되지 않은 경우
			//기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {//로그인 된 경우
			MemberVO memberVO = memberService.selectMember(user.getMem_num());
			viewProfile(memberVO,request,model);
		}
		
		return "imageView";
	}
	
	//프로필 사진 출력(회원번호 지정)
	@RequestMapping("/member/viewProfile.do")
	public String getProfileByMem_num(@RequestParam int mem_num, HttpServletRequest request, Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);
		viewProfile(memberVO,request,model);
		
		return "imageView";
	}
	
	//프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO, HttpServletRequest request, Model model) {
		if(memberVO==null || memberVO.getPhoto_name()==null) {
			//기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else {
			//업로드한 프로필 사진이 있는 경우
			model.addAttribute("imageFile",memberVO.getPhoto());
			model.addAttribute("filename", memberVO.getPhoto_name());
		}
	}
	
	/*============
	 * 프로필 사진 업데이트
	 *============*/
	@RequestMapping("/member/updateMyPhoto.do")
	@ResponseBody
	public Map<String,String> updateProfile(MemberVO memberVO, HttpSession session){
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			memberVO.setMem_num(user.getMem_num());
			memberService.updateProfile(memberVO);
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	/*============
	 * 회원 정보 bar
	 *============*/
	@RequestMapping("/member/memberView.do")
	public String memberView(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원 정보 반환
		MemberVO member = memberService.selectMember(user.getMem_num());
		
		//회원정보
		model.addAttribute("member",member);//member라는 이름으로 member를 넣어줌
		
		return "memberView";
	}
	
	/*============
	 * 예매 내역 bar
	 *============*/
	@RequestMapping("/member/memberReservation.do")
	public String memberReservation(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원 정보 반환
		MemberVO member = memberService.selectMember(user.getMem_num());
		
		//회원정보
		model.addAttribute("member",member);//member라는 이름으로 member를 넣어줌
		
		return "memberReservation";
	}
	
	/*============
	 * 회원 정보 수정
	 *============*/
	//수정 폼 호출
	@GetMapping("/member/update.do")
	public String formUpdate(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO memberVO = memberService.selectMember(user.getMem_num());
		//memberModify.jsp에서 modelAttribute가 memberVO임
		model.addAttribute("memberVO", memberVO);
		
		return "memberModify";
	}
	//전송된 데이터 처리(수정)
	@PostMapping("/member/update.do")
	public String submitUpdate(@Valid MemberVO memberVO, BindingResult result, HttpSession session) {
		log.debug("<<회원정보수정>>:"+memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "memberModify";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());
		
		//회원정보 수정
		memberService.updateMember(memberVO);
		
		//세션에 저장된 정보 변경
		user.setNick_name(memberVO.getNick_name());
		user.setEmail(memberVO.getEmail());
		
		return "redirect:/member/myPage.do";
	}
	
	/*============
	 * 비밀번호 변경
	 *============*/
	//비밀번호 변경 폼 호출
	@GetMapping("/member/changePassword.do")
	public String formChangePassword() {
		return "memberChangePassword";
	}
	//전송된 데이터 처리(비밀번호 변경)
	@PostMapping("/member/changePassword.do")
	public String submitChangePassword(
			@Valid MemberVO memberVO, BindingResult result,
			HttpSession session, HttpServletRequest request,
			Model model) {
		log.debug("<<비밀번호 변경 처리>> : "+memberVO);
		
		//now_passwd와 passwd 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("now_passwd") || result.hasFieldErrors("passwd")) {
			return formChangePassword();
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());//로그인 된 mem_num
		
		//db에 저장된 memberVO
		MemberVO db_member = memberService.selectMember(memberVO.getMem_num());
		//폼에서 전송한 현재 비밀번호와 DB에서 받아온 비밀번호 일치 여부 체크
		if(!db_member.getPasswd().equals(memberVO.getNow_passwd())) {
			//DB에 등록된 비밀번호와 입력한 비밀번호 불일치
			result.rejectValue("now_passwd", "invalidPassword");
			return formChangePassword();
		}
		
		//비밀번호변경
		memberService.updatePassword(memberVO);
		
		//View에 표시할 메시지 처리
		model.addAttribute("message", 
			"비밀번호변경 완료(*재접속시 설정되어 있는 자동로그인 기능 해제)");
		model.addAttribute("url", 
				request.getContextPath() + "/member/myPage.do");
		
		return "common/resultView";
	}
	
	/*============
	* 회원탈퇴
	*============*/
	//회원탈퇴 폼 호출
	@GetMapping("/member/delete.do")
	public String formDelete() {
		return "memberDelete";
	}
	//회원탈퇴 전송된 데이터 처리
	@PostMapping("/member/delete.do")
	public String submitDelete(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model) {
		log.debug("<<회원탈퇴>> : "+memberVO);
		
		//id와 passwd 필드만 유효성 체크
		if(result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return "formDelete";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = memberService.selectMember(user.getMem_num());
		boolean check = false;
		
		//아이디 비밀번호 일치 여부 체크
		try {
			if(db_member!=null && db_member.getId().equals(memberVO.getId())) {
				//여기서 db_member.getId는 로그인된 아이디
				//비밀번호 일치 여부 체크
				check = db_member.isCheckedPassword(memberVO.getPasswd());
			}
			if(check) {
				//인증 성공, 회원정보 삭제
				memberService.deleteMember(user.getMem_num());
				//로그아웃
				session.invalidate();
				
				model.addAttribute("accessMsg", "회원탈퇴를 완료했습니다.");
				return "common/notice";
			}
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			return formDelete();
		}
	
	
	}
	
	
	
}





