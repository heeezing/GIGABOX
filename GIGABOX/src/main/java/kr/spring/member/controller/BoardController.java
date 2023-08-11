package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.BoardService;
import kr.spring.reservation.vo.ReservationVO;
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
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체 검색 레코드 수
		int count = boardService.selectReservationRowCount(map);
		
		log.debug("<<count>> : "+count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,20,10,"memberReservationList.do","&order="+order);
		List<ReservationVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = boardService.selectReservation(map);
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberReservation");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		
		return mav;
	}
}
