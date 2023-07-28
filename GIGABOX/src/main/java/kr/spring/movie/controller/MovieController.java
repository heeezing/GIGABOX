package kr.spring.movie.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;

	/* ===자바빈 초기화=== */
	@ModelAttribute
	public MovieVO initCommand() {
		return new MovieVO();
	}
	/* ===영화 등록=== */
	@GetMapping("/movie/insert.do")
	public String form() {
		return "movieinsert";
	}
	//전송된 데이터 처리
	@PostMapping("/movie/insert.do")
	public String submit(@Valid MovieVO movieVO, BindingResult result, HttpServletRequest request, Model model) {
		
		log.debug("<<영화 등록>> : " + movieVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//영화 등록
		movieService.insertMovie(movieVO);
		
		model.addAttribute("message","영화가 등록되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/movie/list.do");
		
		return "common/resultView";
	}
	/* ===영화 목록=== */
	@RequestMapping("/movie/movieList.do")
	public ModelAndView getList(/*
								 * @RequestParam(value="pageNum",defaultValue="1") int
								 * currentPage, @RequestParam(value="order",defaultValue="1") int order, String
					  			 * keyfield, String keyword
								 */) {
		/*
		 * Map<String,Object> map = new HashMap<String,Object>(); map.put("keyfield",
		 * keyfield); map.put("keyword", keyword);
		 * 
		 * //전체/검색 레코드 수 int count = movieService.selectRowCount(map);
		 * 
		 * //페이지 처리 PagingUtil page = new
		 * PagingUtil(keyfield,keyword,currentPage,count,20,10,"list.do","&order="+order
		 * );
		 */
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("movieList");
		
		return mav;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
