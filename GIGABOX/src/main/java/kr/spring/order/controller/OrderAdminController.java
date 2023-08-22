package kr.spring.order.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.order.service.OrderService;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderAdminController {
	@Autowired
	private OrderService orderService;
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
			주문 목록
	======================*/
	@RequestMapping("/order/admin_list.do")
	public ModelAndView admin_list(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체or검색 레코드 수 읽어오기
		int count = orderService.selectOrderCount(map);
		log.debug("<<count>> : " + count);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"admin_list.do");
		
		//전체or검색 목록 읽어오기
		List<OrderVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = orderService.selectListOrder(map);
		}
		
		//데이터 세팅
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_orderList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}

	
	/*======================
			주문 상세
	======================*/
	
	@RequestMapping("/order/admin_detail.do")
	public String adminDetail(@RequestParam String orders_num, Model model) {
		OrderVO order = orderService.selectOrder(orders_num);
		List<OrderDetailVO> detailList = orderService.selectListOrderDetail(orders_num);
	
		log.debug("<<order>> : " + order);
		log.debug("<<order_detail>> : " + detailList);
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String orders_date = sdf1.format(order.getOrders_date());
		if(order.getModify_date() != null) {
			String modify_date = sdf2.format(order.getModify_date());
			model.addAttribute("modify_date", modify_date);
		}

		model.addAttribute("orders_date", orders_date);
		model.addAttribute("orders", order);
		model.addAttribute("detail", detailList);
		
		return "admin_orderDetail";
	}

	
	/*======================
		  사용 상태 변경
	======================*/
	
	@RequestMapping("/order/admin_statusChange.do")
	@ResponseBody
	public Map<String,String> statusChange(@RequestParam int orders_status,
										  @RequestParam String orders_num,
										  HttpSession session) {
		log.debug("<<주문번호 / 주문상태>> : " + orders_num + " / " + orders_status);
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 X
			mapAjax.put("result","logout");
		}else { //로그인 O
			OrderVO db_order = orderService.selectOrder(orders_num);
			if(db_order.getOrders_status() != 1) {
				mapAjax.put("result","wrongAccess");
			}else {
				if(orders_status == 2) {
					//수정 처리
					orderService.statusChange(orders_num, orders_status);
					mapAjax.put("result","success");
				}else if(orders_status == 4) {
					//취소 주문 건의 적립,사용 포인트 조회
					PointVO db_point = pointService.selectCancelPoint(orders_num);
					int add_point = db_point.getUse_point();
					int use_point = db_point.getAdd_point();
					//사용 포인트는 환불, 적립 포인트는 차감
					PointVO pointVO = new PointVO();
					pointVO.setAdd_point(add_point);
					pointVO.setUse_point(use_point);
					pointVO.setOrders_num(orders_num);
					pointVO.setMem_num(user.getMem_num());
					
					//주문 취소 처리
					orderService.statusChange(orders_num, orders_status);
					pointService.insertRefundPoint(pointVO);
					
					mapAjax.put("result","success");
				}
				
			}
		}

		return mapAjax;
	}
	
	
}
