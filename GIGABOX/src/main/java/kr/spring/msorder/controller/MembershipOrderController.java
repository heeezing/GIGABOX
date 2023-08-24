package kr.spring.msorder.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
    @GetMapping("membership/getOrderInfo.do")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getOrderInfo(@RequestParam int membership_id) {
        Map<String, Object> result = new HashMap<>();
            
        
        try {
            MembershipVO selectedMembership = membershipService.getMembershipById(membership_id);

            result.put("name", selectedMembership.getMembership_grade());
            result.put("price", selectedMembership.getPrice());

            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            result.put("error", "주문 정보를 가져오는데 실패하였습니다.");
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	/*------------------------
	 *  상품 구매
	 *------------------------*/
    
    @PostMapping("/membership/saveOrderInfo.do")
    @ResponseBody
    public ResponseEntity<String> saveOrderInfo(@RequestParam int order_num,
                                                @RequestParam int membership_id) {
        try {
            MembershipOrderVO orderVO = new MembershipOrderVO();
            orderVO.setOrder_num(order_num);
            orderVO.setMembership_id(membership_id);
            
            membershipOrderService.insertOrder(orderVO);

            return new ResponseEntity<>("Order info saved successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error saving order info", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
	//상품 구매 폼 호출
	
	 @RequestMapping("/membership/msorderForm.do")
	    public String showOrderForm(@RequestParam int membership_id,
	    							HttpSession session, Model model,
	    							HttpServletRequest request) {
		 
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
	 public String submit(
			 			  @Valid MembershipOrderVO msorderVO,
			 			  BindingResult result, Model model,
			 			  HttpSession session,
			 			  HttpServletRequest request,
			 			  @RequestParam int membership_id,
			 			  @RequestParam String membership_grade) {		
		 
		 //회원정보 읽어오기
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 
		 msorderVO.setMem_num(user.getMem_num());
		 
		 int order_num = membershipOrderService.selectOrderNum();
	     
	     model.addAttribute("order_num", order_num);
		 
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("mem_num", user.getMem_num());
		 map.put("membership_id", msorderVO.getMembership_id());
		 map.put("membership_grade", msorderVO.getMembership_grade());
		 
		 //상품정보 호출
		MembershipVO membershipVO = membershipService.selectMembership(membership_id);
		
		 
		 membershipOrderService.insertOrder(msorderVO);
		 
		 
		 

		 return "common/notice";
	 }
	 
	 
	 
	 
	}






















