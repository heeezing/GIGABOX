package kr.spring.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.service.OrderService;
import kr.spring.order.vo.OrderVO;
import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private CartService cartService;
	@Autowired
	private SnackService snackService;
	@Autowired
	private MemberService memberService;
	
	
	/*======================
	        자바빈 초기화
	======================*/
	@ModelAttribute
	public OrderVO initCommand() {
		return new OrderVO();
	}
	
	
	/*======================
		 	상품 구매
	======================*/
	
	//주문 폼 호출
	@PostMapping("/order/orderForm.do")
	public String form(OrderVO orderVO, HttpSession session, 
					   Model model, HttpServletRequest request) {
		//장바구니에서 선택한 상품번호들 debug로 확인
		log.debug("<<cart_numbers>> : " + orderVO.getCart_numbers());
		
		if(orderVO.getCart_numbers() == null || orderVO.getCart_numbers().length == 0) {
			model.addAttribute("message", "정상적인 주문이 아닙니다.");
			model.addAttribute("url", request.getContextPath()+"/cart/list.do");
			return "common/resultView"; //자바스크립트 공용 파일로 이동
		}

		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", user.getMem_num());
		map.put("cart_numbers", orderVO.getCart_numbers());
		//장바구니에 담긴 상품 총 주문 금액이 0원일 경우
		int all_total = cartService.selectTotalByMem_num(map);
		int origin_total = cartService.selectOriginTotalByMem_num(map);
		int dc_total = origin_total - all_total;
		if(all_total <= 0) {
			model.addAttribute("message", "정상적인 주문이 아닙니다.");
			model.addAttribute("url", request.getContextPath()+"/cart/list.do");
			return "common/resultView"; 
		}
		
		//장바구니에 담겨있는 상품 정보 호출
		List<CartVO> cartList = cartService.selectListCart(map);
		for(CartVO cart : cartList) {
			SnackVO snack = snackService.selectSnack(cart.getSn_num());
			//상품이 미표시 상태로 바뀌었을 경우
			if(snack.getSn_status() == 1) {
				model.addAttribute("message", "["+snack.getSn_name()+"]판매 중지");
				model.addAttribute("url", request.getContextPath()+"/cart/list.do");
				return "common/resultView";
			}
			
			model.addAttribute("list", cartList);
			model.addAttribute("all_total", all_total);
			model.addAttribute("origin_total", origin_total);
			model.addAttribute("dc_total", dc_total);
		}
		
		//회원 정보 읽어오기
		MemberVO db_member = memberService.selectMember(user.getMem_num());
		model.addAttribute("name", db_member.getName());
		model.addAttribute("phone", db_member.getPhone());
		
		return "orderForm";
	}
	
	
	//주문 폼 - 회원 정보 읽어오기 (이름,전화번호)
	@RequestMapping("/order/getMemberInfo.do")
	@ResponseBody
	public Map<String,Object> formAddress(HttpSession session){
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 X
			mapJson.put("result", "logout");
		}else { //로그인 O
			//회원 정보 읽어오기
			MemberVO db_member = memberService.selectMember(user.getMem_num());
			mapJson.put("result", "success");
			mapJson.put("name", db_member.getName());
			mapJson.put("phone", db_member.getPhone());
		}
		
		return mapJson;
	}
	
}
