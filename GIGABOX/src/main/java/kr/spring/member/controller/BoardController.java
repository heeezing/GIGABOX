package kr.spring.member.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.BoardService;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.order.service.OrderService;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private PointService pointService;
	
	//예매내역 목록
	@RequestMapping("/board/reservationList.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield, String keyword, HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}
		
		//전체 검색 레코드 수
		int count = boardService.selectReservationRowCount(map);
		
		log.debug("<<count>> : "+count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"reservationList.do","&order="+order);
		List<ReservationVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("user", user.getMem_num());
			
			list = boardService.selectReservation(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberReservation");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		
		return mav;
	}
	
	
	//구매내역 목록
	@RequestMapping("/board/orderList.do")
	public ModelAndView orderList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield",keyfield);
		map.put("keyword",keyword);
		map.put("mem_num",user.getMem_num());

		//전체or검색 레코드 수
		int count = orderService.selectOrderCountByMem_num(map);
		log.debug("<<count>> : " + count);

		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"orderList.do");

		List<OrderVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = orderService.selectListOrderByMem_num(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberOrder");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());

		return mav;
	}
	
	//구매 상세
	@RequestMapping("/board/orderDetail.do")
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

		return "memberOrderDetail";
	}
	
	
	//내 선물함 목록
	@RequestMapping("/board/giftList.do")
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
		mav.setViewName("memberGift");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
	
	//내 선물함 상세
	@RequestMapping("/board/giftDetail.do")
	public String giftDetail(@RequestParam String orders_num, Model model) {
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

		return "memberGiftDetail";
	}
	
	
	//포인트 내역 목록
	@RequestMapping("/board/pointList.do")
	public ModelAndView getListAdmin(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									 HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//나의 총 포인트
		int totalPoint = pointService.myTotalPoint(user.getMem_num());
		//나의 멤버십
		String membership = orderService.selectMembershipByMem_num(user.getMem_num());
		if(membership == null) {
			membership = "BASIC";
		}else {
			membership = membership.toUpperCase();
		}
			
		String pointRate = "";
		if(membership == "BASIC") {
			pointRate = "3%";
		}else if(membership == "BRONZE") {
			pointRate = "5%";
		}else if(membership == "SILVER") {
			pointRate = "7%";
		}else if(membership == "GOLD") {
			pointRate = "10%";
		}
		
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("mem_num", user.getMem_num());
		
		//전체or검색 레코드 수
		int count = pointService.selectPointCountByMem_num(map);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,10,10,"pointList.do");
	
		//목록 읽어오기
		List<PointVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = pointService.selectPointListByMem_num(map);
			log.debug("<<목록>> : " + list);
		}
		
		//뷰에서 사용할 수 있도록 데이터 넣어놓기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberPoint"); //tiles 설정
		mav.addObject("user", user);
		mav.addObject("totalPoint", totalPoint);
		mav.addObject("membership", membership);
		mav.addObject("pointRate", pointRate);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}

	
	//관람평 목록
	@RequestMapping("/board/reviewList.do")
	public ModelAndView reviewList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
				  				  @RequestParam(value="order", defaultValue="1") int order,
				  				  String keyfield, String keyword, HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}
		
		//전체 검색 레코드 수
		int count=boardService.selectReviewRowCount(map);
		
		log.debug("<<reviewcount>> : "+count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"reviewList.do","&order="+order);
		List<ReviewVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("user", user.getMem_num());
			
			list = boardService.selectReview(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberReview");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		
		return mav;
	}
	
	
	//포스트 목록
	@RequestMapping("/board/postList.do")
	public ModelAndView postList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
				  				  @RequestParam(value="order", defaultValue="1") int order,
				  				  String keyfield, String keyword, HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			map.put("mem_num", user.getMem_num());
		}
		
		//전체 검색 레코드 수
		int count=boardService.selectPostRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"postList.do","&order="+order);
		List<PostVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("user", user.getMem_num());
			
			list = boardService.selectPost(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberPost");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		
		return mav;
	}
	
	
	
}
