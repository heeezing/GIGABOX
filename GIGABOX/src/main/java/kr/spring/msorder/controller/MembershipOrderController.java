package kr.spring.msorder.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.membership.service.MembershipService;
import kr.spring.membership.vo.MembershipVO;
import kr.spring.msorder.service.MembershipOrderService;
import kr.spring.msorder.vo.MembershipOrderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipOrderController {
	@Autowired 
	private MembershipOrderService msorderService;
	@Autowired
	private MembershipService membershipService;
	@Autowired
	private MemberService memberService;
	
	
	
	@ModelAttribute
	public MembershipOrderVO initCommand() {
		return new MembershipOrderVO();
	}
	/*------------------------
	 *  상품 구매
	 *------------------------*/
	//상품 구매 폼 호출
	
	 @RequestMapping("/membership/msorderForm.do")
	    public String showOrderForm(@RequestParam("membership_id") 
	    							int membershipId,
	    							HttpSession session, Model model,
	    							HttpServletRequest request) {
		 
	     MemberVO user = (MemberVO)session.getAttribute("user");  
	     Map<String, Object> map = new HashMap<String, Object>();
	     map.put("mem_num", user.getMem_num());
	     map.put("membership_id", membershipId);
	     
		 
	     List<MembershipVO> membershipList = membershipService.selectMembershipUserList(map);
	     MembershipVO selectedMembership = membershipService.getMembershipById(membershipId);
	     
	     model.addAttribute("selectedMembership", selectedMembership);
	     model.addAttribute("list", membershipList);
	     
	     return "msorderForm";  
	     
	    }
	 
	 //전송된 데이터 처리
	 @PostMapping("membership/msorder.do")
	 public String submit(@Valid MembershipOrderVO msorderVO,
			 			  BindingResult result, Model model,
			 			  HttpSession session,
			 			  HttpServletRequest request,
			 			  HttpServletResponse response) {
		 log.debug("<<MembershipOrderVO>> : " + msorderVO);

		 //전송된 데이터 유효성 체크 결과 오류가 있으면 폼 호출
		 if(result.hasErrors()) {
			 return showOrderForm(msorderVO.getMembership_id(), 
					 			  session,model,request);
		 }
		 
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("mem_num", user.getMem_num());
		 map.put("membership_id", msorderVO.getMembership_id());
		 
		 //상품정보 호출
		 List<MembershipVO> membershipList = membershipService.selectMembershipUserList(map);
		 
		 
		 

		 return "common/notice";
	 }
	 
	 
	 
	 
	}






















