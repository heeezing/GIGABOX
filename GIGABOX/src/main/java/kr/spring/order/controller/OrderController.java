package kr.spring.order.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.cart.vo.CartVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.service.OrderService;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.point.service.PointService;
import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import kr.spring.util.PagingUtil;
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
	@Autowired
	private PointService pointService;
	
	
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
	
	/*------ 바로 구매 주문 폼 호출 -------*/
	
	@RequestMapping("/order/directOrderForm.do")
	public String snackForm(@Valid OrderVO orderVO, HttpSession session, 
							Model model, HttpServletRequest request) {
		log.debug("<<orderVO>> : " + orderVO);
		
		//로그인 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", request.getContextPath()+"/member/login.do");
			return "common/resultView";
		}
		
		//상품 정보 호출
		SnackVO snack = snackService.selectSnack(orderVO.getSn_num());
		log.debug("<<snack>> : " + snack);
		
		//상품이 미표시 상태로 바뀌었을 경우
		if(snack.getSn_status() == 1) {
			model.addAttribute("message", "["+snack.getSn_name()+"]판매 중지");
			model.addAttribute("url", request.getContextPath()+"/snack/list.do");
			return "common/resultView";
		}
		//가격 처리
		int all_total = 0;
		if(snack.getSn_dc_price() == 0) {
			all_total = snack.getSn_price() * orderVO.getOrders_quantity();
		}else {
			all_total = snack.getSn_dc_price() * orderVO.getOrders_quantity();
		}
		int origin_total = snack.getSn_price() * orderVO.getOrders_quantity();
		int dc_total = origin_total - all_total;
		if(all_total <= 0) {
			model.addAttribute("message", "정상적인 주문이 아닙니다.");
			model.addAttribute("url", request.getContextPath()+"/cart/list.do");
			return "common/resultView"; 
		}

		boolean singleProduct = true; //단일구매인 것을 분류할 변수 생성
		model.addAttribute("singleProduct", singleProduct);
		model.addAttribute("snack", snack);
		model.addAttribute("all_total", all_total);
		model.addAttribute("origin_total", origin_total);
		model.addAttribute("dc_total", dc_total);
		model.addAttribute("orders_quantity", orderVO.getOrders_quantity());
		model.addAttribute("sn_num", orderVO.getSn_num());
		//선물or일반구매 여부
		model.addAttribute("orders_type", orderVO.getOrders_type());
	
		//주문번호 미리 생성 후 넘기기
		String orders_num = orderService.selectOrderNum();
		model.addAttribute("orders_num", orders_num);
		
		//회원 정보 읽어오기
		MemberVO member = memberService.selectMember(user.getMem_num());
		log.debug("<<member>> : " + member);
		int totalPoint = pointService.myTotalPoint(user.getMem_num());
		log.debug("<<totalPoint>> : " + totalPoint);

		model.addAttribute("member", member);
		model.addAttribute("have_point", totalPoint);
		
		return "orderForm";
	}
	
	
	
	/*------ 장바구니 경유 주문 폼 호출 -------*/
	
	@PostMapping("/order/orderForm.do")
	public String cartForm(OrderVO orderVO, HttpSession session, 
						   Model model, HttpServletRequest request) {
		//장바구니에서 선택한 상품번호들 debug로 확인
		log.debug("<<cart_numbers>> : " + orderVO.getCart_numbers());
		
		//로그인 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", request.getContextPath()+"/member/login.do");
			return "common/resultView";
		}
		
		if(orderVO.getCart_numbers() == null || orderVO.getCart_numbers().length == 0) {
			model.addAttribute("message", "정상적인 주문이 아닙니다.");
			model.addAttribute("url", request.getContextPath()+"/cart/list.do");
			return "common/resultView"; //자바스크립트 공용 파일로 이동
		}

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", user.getMem_num());
		map.put("cart_numbers", orderVO.getCart_numbers());
		//장바구니에 담긴 상품 총 주문 금액이 0원일 경우
		int all_total = cartService.selectTotalByMem_num(map); //할인가 있을 경우 총합
		int origin_total = cartService.selectOriginTotalByMem_num(map); //원가 총합
		int dc_total = origin_total - all_total; //할인 받은 금액
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
		
		//주문 상품의 대표 상품명 세팅
		String sn_name = "";
		if(cartList.size() == 1) { //상품 하나 구매 시
			sn_name = cartList.get(0).getSnackVO().getSn_name();
		}else { //여러 상품 구매 시 
			sn_name = cartList.get(0).getSnackVO().getSn_name() + " 외 " + (cartList.size()-1) + "건";
		}
		model.addAttribute("sn_name", sn_name);
		
		//주문번호 미리 생성 후 넘기기
		String orders_num = orderService.selectOrderNum();
		model.addAttribute("orders_num", orders_num);
		//선물or일반구매 여부
		model.addAttribute("orders_type", orderVO.getOrders_type());
		
		//회원 정보 읽어오기
		MemberVO member = memberService.selectMember(user.getMem_num());
		log.debug("<<member>> : " + member);
		int totalPoint = pointService.myTotalPoint(user.getMem_num());
		log.debug("<<totalPoint>> : " + totalPoint);

		model.addAttribute("member", member);
		model.addAttribute("have_point", totalPoint);
		
		return "orderForm";
	}
	
	
	/*------ 전송된 데이터 처리 -------*/
	
	@PostMapping("/order/order.do")
	public String submit(@Valid OrderVO orderVO, BindingResult result,
						 HttpSession session, Model model,
						 HttpServletRequest request,
						 HttpServletResponse response,
						 @RequestParam boolean isDirectOrder) {
		log.debug("<<OrderVO>> : " + orderVO);
		log.debug("<<isDirectOrder>> : " + isDirectOrder);
		
		
		if(isDirectOrder) { //단일 구매 시
			//전송된 데이터 유효성 체크 결과, 오류 있으면 폼을 다시 호출
			if(result.hasErrors()) {
				return snackForm(orderVO,session,model,request);
			}

			//상품 정보 호출
			SnackVO snack = snackService.selectSnack(orderVO.getSn_num());
			log.debug("<<snack>> : " + snack);
			
			//상품이 미표시 상태로 바뀌었을 경우
			if(snack.getSn_status() == 1) {
				model.addAttribute("message", "["+snack.getSn_name()+"]판매 중지");
				model.addAttribute("url", request.getContextPath()+"/snack/list.do");
				return "common/resultView";
			}
			//가격 처리
			int all_total = 0;
			if(snack.getSn_dc_price() == 0) {
				all_total = snack.getSn_price() * orderVO.getOrders_quantity();
			}else {
				all_total = snack.getSn_dc_price() * orderVO.getOrders_quantity();
			}
			if(all_total <= 0) {
				model.addAttribute("message", "정상적인 주문이 아닙니다.");
				model.addAttribute("url", request.getContextPath()+"/snack/snackDetail.do?sn_num="+orderVO.getSn_num());
				return "common/resultView"; 
			}
			//포인트 차감 후 결제 예정 금액
			int final_total = all_total - orderVO.getUse_point();
			log.debug("<<합계금액 - 사용포인트 = 최종금액>> : " + all_total + " - " +orderVO.getUse_point()+" = "+final_total);
			
			orderVO.setSn_name(snack.getSn_name());
			orderVO.setOrders_total(all_total); //총 상품 금액
			orderVO.setPay_total(final_total); //총 결제 금액
			
			//정상적으로 주문될 시 개별 주문 상품 정보를 저장할 list 생성
			List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
			//개별 상품 정보 저장
			for(int i=1 ; i<=orderVO.getOrders_quantity() ; i++) {
				OrderDetailVO orderDetail = new OrderDetailVO();
				String detail_num = orderService.selectDetailNum();
				orderDetail.setDetail_num(detail_num);
				orderDetail.setSn_num(orderVO.getSn_num());
				orderDetail.setSn_detail(snack.getSn_detail());
				orderDetail.setSn_name(snack.getSn_name());
				orderDetail.setSn_price(snack.getSn_price());
				orderDetail.setSn_dc_price(snack.getSn_dc_price());
				orderDetail.setOrders_quantity(1);
				
				orderDetailList.add(orderDetail);
			}

			
			//회원 멤버십 정보 확인
			MemberVO user = (MemberVO)session.getAttribute("user");
			String membership = orderService.selectMembershipByMem_num(user.getMem_num());
			//멤버십에 따른 적립포인트 계산
			int add_point = 0;
			if(membership == "bronze") {
				add_point = (int) (all_total * 0.05);
			}else if(membership == "silver") {
				add_point = (int) (all_total * 0.07);
			}else if(membership == "gold") {
				add_point = (int) (all_total * 0.1);
			}else {
				add_point = (int) (all_total * 0.03);
			}
			
			orderVO.setMem_num(user.getMem_num());
			orderVO.setAdd_point(add_point); //적립 포인트 세팅
			orderVO.setUse_point(orderVO.getUse_point()); //사용 포인트 세팅
			
			if(orderVO.getOrders_type() == 2) {
				//선물 등록 처리
				orderVO.setFrom_id(user.getId());
				orderService.insertGiftOrder(orderVO, orderDetailList);
			}else {
				//주문 등록 처리
				orderService.insertOrder(orderVO, orderDetailList);
			}

			//완료 화면에 주문 번호 넘기기
			model.addAttribute("orders_num", orderVO.getOrders_num());
			
			return "redirect:/order/orderComplete.do";
			
		}else { //장바구니 경유 구매 시
			//전송된 데이터 유효성 체크 결과, 오류 있으면 폼을 다시 호출
			if(result.hasErrors()) {
				return cartForm(orderVO,session,model,request);
			}
			
			//비정상적인 주문의 경우 - 담긴 상품이 없는데 오류로 인해 넘어왔을 시
			if(orderVO.getCart_numbers() == null || orderVO.getCart_numbers().length == 0) {
				model.addAttribute("message", "정상적인 주문이 아닙니다.");
				model.addAttribute("url", request.getContextPath()+"/cart/list.do");
				return "common/resultView"; //자바스크립트 공용 파일로 이동
			}
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("mem_num", user.getMem_num());
			map.put("cart_numbers", orderVO.getCart_numbers());
			int all_total = cartService.selectTotalByMem_num(map);
			//비정상적인 주문의 경우 - 총 주문 금액이 0이나 음수일 시
			if(all_total <= 0) {
				model.addAttribute("message", "정상적인 주문이 아니거나 상품의 수량이 부족합니다.");
				model.addAttribute("url", request.getContextPath()+"/cart/list.do");
				return "common/resultView"; //자바스크립트 공용 파일로 이동
			}

			//장바구니에 담겨있는 상품 정보를 호출해 list에 저장
			List<CartVO> cartList = cartService.selectListCart(map);
			//정상적으로 주문될 시 개별 주문 상품 정보를 저장할 list 생성
			List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
			
			for(CartVO cart : cartList) {
				SnackVO Snack = snackService.selectSnack(cart.getSn_num());
				//상품이 미표시 상태로 바뀌었을 경우
				if(Snack.getSn_status() == 1) {
					model.addAttribute("message", "["+Snack.getSn_name()+"]판매 중지");
					model.addAttribute("url", request.getContextPath()+"/cart/list.do");
					return "common/resultView";
				}
				//개별 상품 정보 저장
				for(int i=1 ; i<=cart.getOrders_quantity() ; i++) {
					OrderDetailVO orderDetail = new OrderDetailVO();
					String detail_num = orderService.selectDetailNum();
					orderDetail.setDetail_num(detail_num);
					orderDetail.setSn_num(cart.getSn_num());
					orderDetail.setSn_detail(cart.getSnackVO().getSn_detail());
					orderDetail.setSn_name(cart.getSnackVO().getSn_name());
					orderDetail.setSn_price(cart.getSnackVO().getSn_price());
					orderDetail.setSn_dc_price(cart.getSnackVO().getSn_dc_price());
					orderDetail.setOrders_quantity(1);
					
					orderDetailList.add(orderDetail);
					
				}
			}

			//주문 상품의 대표 상품명 세팅
			String sn_name = "";
			if(cartList.size() == 1) { //상품 하나 구매 시
				sn_name = cartList.get(0).getSnackVO().getSn_name();
			}else { //여러 상품 구매 시 
				sn_name = cartList.get(0).getSnackVO().getSn_name() + " 외 " + (cartList.size()-1) + "건";
			}
			orderVO.setSn_name(sn_name);
			
			//포인트 차감 후 결제 예정 금액
			int final_total = all_total - orderVO.getUse_point();
			
			//회원 멤버십 정보 확인
			String membership = orderService.selectMembershipByMem_num(user.getMem_num());
			//멤버십에 따른 적립포인트 계산
			int add_point = 0;
			if(membership == "bronze") {
				add_point = (int) (all_total * 0.05);
			}else if(membership == "silver") {
				add_point = (int) (all_total * 0.07);
			}else if(membership == "gold") {
				add_point = (int) (all_total * 0.1);
			}else {
				add_point = (int) (all_total * 0.03);
			}
			
			orderVO.setMem_num(user.getMem_num());
			orderVO.setOrders_total(all_total); //총 상품 금액 세팅
			orderVO.setPay_total(final_total); //총 결제 금액 세팅
			orderVO.setAdd_point(add_point); //적립 포인트 세팅
			orderVO.setUse_point(orderVO.getUse_point()); //사용 포인트 세팅
			
			if(orderVO.getOrders_type() == 2) {
				//선물 등록 처리
				orderVO.setFrom_id(user.getId());
				orderService.insertGiftOrder(orderVO, orderDetailList);
			}else {
				//주문 등록 처리
				orderService.insertOrder(orderVO, orderDetailList);
			}
			
			//완료 화면에 주문 번호 넘기기
			model.addAttribute("orders_num", orderVO.getOrders_num());
			
			return "redirect:/order/orderComplete.do";
		}

	}


	
	/*======================
	 	 결제 결과 화면 
	======================*/
	//성공
	@RequestMapping("/order/orderComplete.do")
	public String complete(HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String orders_num = orderService.getOrders_num(user.getMem_num());
		model.addAttribute("orders_num", orders_num);
		return "orderComplete"; //tiles 설정
	}
	
	//실패
	@RequestMapping("/order/orderFail.do")
	public String fail() {
		return "orderFail"; //tiles 설정
	}
	
	
	
	/*======================
		 선물하기 회원 조회
	======================*/
	
	@RequestMapping("/order/searchMember.do")
	@ResponseBody //제이슨 문자열로 만듬 - ajax통신을 위해 (Map or 자바빈을 넘기면 됨)
	public Map<String,String> searchMember(@RequestParam String to_id, @RequestParam String to_phone){
		log.debug("<<선물하기 - 회원조회>> : " + to_id + "//" + to_phone);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO member = orderService.searchMember(to_id, to_phone);
		if(member!=null) {
			//일치하는 회원 정보가 있는 경우
			mapAjax.put("result","success");
		}else if(member == null){
			//일치하는 회원 정보가 없는 경우
			mapAjax.put("result", "notFound");
		}
		
		return mapAjax;
	}
	
	
	
	/*======================
		  선물함 목록 조회
	======================*/
	
	@RequestMapping("/order/giftList.do")
	public ModelAndView admin_list(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("to_id", user.getId());
		
		//전체or검색 레코드 수 읽어오기
		int count = orderService.selectGiftCountByTo_id(map);
		log.debug("<<count>> : " + count);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"gift_list.do");
		
		//전체or검색 목록 읽어오기
		List<OrderVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = orderService.selectListGiftByTo_id(map);
		}
		
		//데이터 세팅
		ModelAndView mav = new ModelAndView();
		mav.setViewName("giftList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
}
