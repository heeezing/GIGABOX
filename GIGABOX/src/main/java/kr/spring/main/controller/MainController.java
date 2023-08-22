package kr.spring.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.cs.vo.CsVO;
import kr.spring.event.vo.EventVO;
import kr.spring.main.service.MainService;
import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	private MainService mainService;
	
	@RequestMapping("/")
	public String main() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {
		
		List<MovieVO> mList = mainService.selectBoxOffice();
		log.debug("<<박스오피스 - 상위 4개 영화>> : " + mList);
		model.addAttribute("mList", mList);
		
		List<EventVO> eList = mainService.selectEvent();
		log.debug("<<이벤트 - 최신 4개 이벤트>> : " + eList);
		model.addAttribute("eList", eList);
		
		List<CsVO> nList = mainService.selectNotice();
		log.debug("<<공지사항 - 최신 1개 공지>> : " + nList);
		model.addAttribute("nList", nList);
		
		return "main2";//타일스 설정의 식별자
	}
}




