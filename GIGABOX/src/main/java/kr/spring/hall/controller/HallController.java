package kr.spring.hall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.hall.service.HallService;
import kr.spring.hall.vo.HallVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HallController {
	@Autowired
	private HallService hallService;
	
	/*========================
	 *  상영관 등록
	 *========================*/
	// 등록 폼
	@GetMapping("/hall/hallAdd.do")
	public String form(Model model) {
		// 극장 정보 불러오기
		model.addAttribute("TheaterList", hallService.getTheaterList());
		return "hallAdd";
	}
	// 전송된 데이터 처리
	@PostMapping("/hall/hallAdd.do")
	public String submit(HallVO hallVO,BindingResult result,HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<게시판 글쓰기>> : " + hallVO);
		
		hallService.insertHall(hallVO);
		
		model.addAttribute("message", "상영관 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/hall/hallList.do");
		
		return "common/resultView";
	}
	
	/*========================
	 *  상영관 목록
	 *========================*/
	@RequestMapping("/hall/hallList.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,  String keyfield, String keyword) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = hallService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "hallList.do");
		
		List<HallVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = hallService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("hallList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*===============
	 * 상영관 수정
	 *===============*/
	// 수정 폼 호출
	@GetMapping("/hall/hallUpdate.do")
	public String formUpdate(@RequestParam int hall_num,Model model) {
		HallVO hallVO = hallService.selectHall(hall_num);
		model.addAttribute("hallVO",hallVO);
		model.addAttribute("TheaterList", hallService.getTheaterList());
		
		return "hallModify";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/hall/hallUpdate.do")
	public String submitUpdate(HallVO hallVO,BindingResult result,HttpServletRequest request,Model model) {
		log.debug("<<상영관 수정 - HallVO>> : " + hallVO);
		
		// 상영관 수정
		hallService.updateHall(hallVO);
		
		// View에 표시할 메시지
		model.addAttribute("message", "상영관 수정 완료");
		model.addAttribute("url", request.getContextPath()+"/hall/hallList.do");
		
		return "common/resultView";
	}
	
}
