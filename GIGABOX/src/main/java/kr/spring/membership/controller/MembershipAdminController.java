package kr.spring.membership.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.util.FileUtil;
import kr.spring.membership.service.MembershipService;
import kr.spring.membership.vo.MembershipVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipAdminController {
	@Autowired
	private MembershipService membershipService;
	
	/*=======================
	 * 자바빈 초기화
	 *=======================*/
	@ModelAttribute
	public MembershipVO initCommand() {
		return new MembershipVO();
	}
	
	/*=================================
	 * 멤버십목록 - 관리자
	 *=================================*/
	@RequestMapping("/membership/admin_membership_list.do")
	public ModelAndView process(
			@RequestParam(value="pageNum", defaultValue="1")
			int currentPage, String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = membershipService.selectMembershipCount(map);
		
		log.debug("<<count>> : " + count);
		log.debug("==keyfield== : " + keyfield);
		log.debug("==keyword== : " + keyword);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,
								count,20,10,"admin_membership_list.do");
		
		List<MembershipVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = membershipService.selectMembershipList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_membershipList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;		
	}
	
	/*=======================
	 * 멤버십 등록
	 *=======================*/
	//멤버십 등록 폼 호출
	@GetMapping("/membership/registerMembership.do")
	public String form() {
		return "membershipRegister";
	}
	//전송된 데이터 처리
	@PostMapping("/membership/registerMembership.do")
	public String submit(@Valid MembershipVO membershipVO,
						 BindingResult result,Model model,
						 HttpServletRequest request,
						 HttpSession session) {
		log.debug("<<멤버십 등록>> : " + membershipVO);
		
		//멤버십 이미지 유효성 체크
		//MultipartFile -> byte[]로 변환한 경우 파일을 업로드하지 않으면
		//byte[]은 생성되고 length는 0임
		if(membershipVO.getPhoto().length == 0) {
			result.rejectValue("photo", "required");
		}
		
		if(membershipVO.getPhoto().length>=5*1024*1024) {//5Mb
			result.rejectValue("photo", "limitUploadSize",new Object[] {"5Mb"},null);
		}
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		/*if(result.hasErrors()) {
			return form();
		}*/
		
		membershipService.insertMembership(membershipVO);
		
		model.addAttribute("message", "등록이 완료되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/membership/admin_membership_list.do");
		
		return "common/resultView";
		
	}
	
	/*=======================
	 * 멤버십 수정
	 *=======================*/
	//멤버십 수정 폼 호출
	@GetMapping("/membership/membership_update.do")
	public String formUpdate(@RequestParam int membership_id, Model model) {
		
		MembershipVO membershipVO = membershipService.selectMembership(membership_id);
		
		model.addAttribute("membershipVO", membershipVO);
		
		return "membershipModify";
	}
	
	//사진 처리
	public void viewPhoto(MembershipVO membershipVO, HttpServletRequest request,
							Model model) {
		if(membershipVO==null || membershipVO.getPhoto_name()==null) {
			//기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/no_image.jpg"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "no_image.jpg");
		}else {//업로드한 사진이 있는 경우
			model.addAttribute("imageFile", membershipVO.getPhoto());
			model.addAttribute("filename", membershipVO.getPhoto_name());
			
		}
	}
	
	//전송된 데이터 처리
	@PostMapping("/membership/membership_update.do")
	public String submitUpdate(@Valid MembershipVO membershipVO,
									  HttpServletRequest request,
									  BindingResult result,
									  Model model) {
		log.debug("<<멤버십 수정 - MembershipVO>> : " + membershipVO);
		
		membershipService.updateMembership(membershipVO);
		
		model.addAttribute("message", "수정 완료!");
		model.addAttribute("url", 
				request.getContextPath()
				+"/membership/membership_list.do?membership_id"
						+membershipVO.getMembership_id());
		
		return "common/resultView";
	}
	
	/*========================
	 * 멤버십 삭제
	 *========================*/
	@RequestMapping("/membership/membership_delete.do")
	public String submitDelete(
				  @RequestParam int membership_id) {
		log.debug("<<멤버십 삭제 - membership_id>> : " + membership_id);
		
		membershipService.deleteMembership(membership_id);
		
		return "redirect:/membership/membership_list.do";
	}
	
}




















