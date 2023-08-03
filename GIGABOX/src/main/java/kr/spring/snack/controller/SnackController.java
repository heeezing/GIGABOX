package kr.spring.snack.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SnackController {
	@Autowired
	private SnackService snackService;
	
	/*======================
		   자바빈 초기화
	======================*/
	@ModelAttribute
	public SnackVO initCommand() {
		return new SnackVO();
	}

	
	/*======================
		 	스낵 목록
	======================*/	
	
	@RequestMapping("/snack/list.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="sn_category",defaultValue="1") int sn_category) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		//전체or검색 레코드 수
		int count = snackService.selectUserSnackCount(sn_category);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,9,10,"list.do","&sn_category="+sn_category);
		
		//목록 읽어오기
		List<SnackVO> list = null;
		if(count > 0) {
			map.put("sn_category", sn_category);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = snackService.selectUserSnackList(map);
			log.debug("<<목록>> : " + list);
		}
		
		//뷰에서 사용할 수 있도록 데이터 넣어놓기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("snackList"); //tiles 설정
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("sn_category", sn_category);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
}
