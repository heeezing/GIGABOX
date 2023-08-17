package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.BoardService;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.review.vo.ReviewVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
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
	public ModelAndView orderList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
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
		int count=boardService.selectOrderRowCount(map);
		
		log.debug("<<ordercount>> : "+count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"orderList.do","&order="+order);
		List<OrderVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("user", user.getMem_num());
			
			list = boardService.selectOrder(map);
		}
		log.debug("<<orderorder>>"+list);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberOrder");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		
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
