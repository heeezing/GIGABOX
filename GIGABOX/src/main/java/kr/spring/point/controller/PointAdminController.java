package kr.spring.point.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PointAdminController {
	@Autowired
	private PointService pointService;
	
	/*======================
		   자바빈 초기화
	======================*/
	@ModelAttribute
	public PointVO initCommand() {
		return new PointVO();
	}
	
	
	/*======================
		  포인트 내역	
	======================*/
	
	@RequestMapping("/point/admin_list.do")
	public ModelAndView getListAdmin(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체or검색 레코드 수
		int count = pointService.selectPointCount(map);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"admin_list.do");
	
		//목록 읽어오기
		List<PointVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = pointService.selectPointList(map);
			log.debug("<<목록>> : " + list);
		}
		
		//뷰에서 사용할 수 있도록 데이터 넣어놓기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_pointList"); //tiles 설정
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	
	
}
