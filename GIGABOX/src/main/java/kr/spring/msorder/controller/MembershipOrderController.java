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
	@Autowired
	private MembershipOrderService membershipOrderService;
	
	
	
	@ModelAttribute
	public MembershipOrderVO initCommand() {
		return new MembershipOrderVO();
	}
	/*------------------------
	 *  상품 구매
	 *------------------------*/
	//상품 구매 폼 호출
	
	 @RequestMapping("/membership/msorderForm.do")
	    public String showOrderForm(@RequestParam int membership_id,
	    							MembershipOrderVO msorderVO,	    							
	    							HttpSession session, Model model,
	    							HttpServletRequest request) {
		 log.debug("<<membershipOrderVO>> : " +msorderVO);
		 
		 //회원정보 읽어오기
	     MemberVO user = (MemberVO)session.getAttribute("user"); 
	     log.debug("<<user>> : " + user);
	     
	    //주문번호 생성?
	     int order_num = membershipOrderService.selectOrderNum();
	     
	     model.addAttribute("order_num", order_num);
	     
		 
	     MembershipVO selectedMembership = membershipService.getMembershipById(membership_id);
	     
	     model.addAttribute("selectedMembership", selectedMembership);
	     
	     return "msorderForm";  
	     
	    }
	 
	 //전송된 데이터 처리
	 @PostMapping("membership/msorder.do")
	 public String submit(@RequestParam int order_num,
			 			  @Valid MembershipOrderVO msorderVO,
			 			  BindingResult result, Model model,
			 			  HttpSession session,
			 			  HttpServletRequest request,
			 			  @RequestParam int membership_id ) {		
		 
		 //회원정보 읽어오기
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 log.debug("<<order_num>> : " + order_num);
		 
		 msorderVO.setMem_num(user.getMem_num());
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("mem_num", user.getMem_num());
		 map.put("membership_id", msorderVO.getMembership_id());
		 
		 //상품정보 호출
		MembershipVO membershipVO = membershipService.selectMembership(membership_id);
		
		 
		 membershipOrderService.insertOrder(msorderVO);
		 
		 model.addAttribute("order_num", msorderVO.getOrder_num());
		 
		 

		 return "common/notice";
	 }
	 
	 
	 
	 
	}






















