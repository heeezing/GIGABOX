package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

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
			
			if(check) {
				
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
	
	
	
}
