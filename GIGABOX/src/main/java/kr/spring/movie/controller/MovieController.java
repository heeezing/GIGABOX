package kr.spring.movie.controller;


import java.util.HashMap;
import java.util.List;
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
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;

	/* =========================자바빈 초기화=============================== */
	@ModelAttribute
	public MovieVO initCommand() {
		return new MovieVO();
	}

	/* =========================영화 등록=============================== */
	@GetMapping("/movie/movieRegister.do")
	public String form() {
		return "movieRegister";
	}

	// 전송된 데이터 처리
	@PostMapping("/movie/movieRegister.do")
	public String submit(@Valid MovieVO movieVO, BindingResult result, HttpServletRequest request, Model model) {
		log.debug("<<영화 등록>> : " + movieVO);

		// 유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			return form();
		}

		// 글쓰기
		movieService.registerMovie(movieVO);

		model.addAttribute("message", "영화가 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/movie/movieList.do");

		return "common/resultView";
	}

	/*
	 * ===api 불러오기(작업중)===
	 * 
	 * @RequestMapping("/movie/insertApi.do")
	 * 
	 * @ResponseBody public Map<String,Object> insertApi(MovieVO movieVO){
	 * log.debug("<<api등록>> : " + movieVO);
	 * 
	 * // Map<String,Object> mapJson = new HashMap<String,Object>(); //
	 * mapJson.put("movies", movieVO.getMovielist());
	 * 
	 * // HashMap에서 movieList 가져오기 // List<MovieVO> retrievedMovieList =
	 * mapJson.get("movies");
	 * 
	 * // 출력해보기 // for (MovieVO movie : retrievedMovieList) { //
	 * System.out.println("영화 제목: " + movie.getM_title()); //
	 * System.out.println("감독: " + movie.getM_director()); //
	 * System.out.println("관람등급: " + movie.getM_rating()); //
	 * System.out.println("--------------------"); // }
	 * movieService.insertMovie(movieVO);
	 * 
	 * return null; }
	 */

	/* =========================영화 목록=============================== */

	@RequestMapping("/movie/movieList.do")
	public ModelAndView getList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCount(map); // 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "movieList.do",
				"&order=" + order);

		List<MovieVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());

			map.put("end", page.getEndRow());

			list = movieService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("movieList");
		mav.addObject("count", count);
		mav.addObject("movies", list);
		mav.addObject("page", page.getPage());

		return mav;
	}
	
	/* =========================이미지 출력=============================== */
	@RequestMapping("/movie/imageView.do")
	public ModelAndView viewImage(@RequestParam int movie_num,
			                      @RequestParam int movie_type) {
		
		MovieVO movie = movieService.selectMovie(movie_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		if(movie_type==1) {//poster
			mav.addObject("imageFile", movie.getM_poster());
			mav.addObject("filename", movie.getPoster_name());
		}else if(movie_type==2) {//stllimg
			mav.addObject("imageFile", movie.getM_stllimg());
			mav.addObject("filename", movie.getStllimg_name());
		}
		
		return mav;
	}

	
	/* =========================영화 상세페이지=============================== */
	@RequestMapping("/movie/movieDetail.do")
	public ModelAndView getDetail(@RequestParam int movie_num) {
		log.debug("<<영화 상세>> : " + movie_num);
		
		//글 상세
		MovieVO movie = movieService.selectMovie(movie_num);
		
		//제목에 태그를 허용하지 않음
		movie.setM_title(StringUtil.useNoHtml(movie.getM_title()));
		
		//내용에 태그 불허
		movie.setM_plot(StringUtil.useBrNoHtml(movie.getM_plot()));
		
		return new ModelAndView("movieDetail","movie",movie);
	}
	
	/* =========================영화 수정=============================== */
	//수정 폼 호출
	@GetMapping("/movie/movieUpdate.do")
	public String formUpdate(@RequestParam int movie_num,Model model) {
		MovieVO movie = movieService.selectMovie(movie_num);
		model.addAttribute("movieVO",movie);
		
		return "movieModify";
	}
	//전송된 데이터 처리
	@PostMapping("/movie/movieUpdate.do")
	public String submitUpdate(@Valid MovieVO movie, BindingResult result, HttpServletRequest request, Model model) {
		
		log.debug("<<영화 수정 - MovieVO>> : " + movie);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "movieModify";
		}
		//글수정
		movieService.updateMovie(movie);
		
		//view에 표시할 메세지
		model.addAttribute("message","영화 수정이 완료되었습니다!");
		model.addAttribute("url",request.getContextPath() + "/movie/movieDetail.do?movie_num=" + movie.getMovie_num());
		
		return "common/resultView";
	}
	
	/* =========================관리자=============================== */
	@RequestMapping("/movie/movieAdmin.do")
	public ModelAndView getadminList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCount(map); // 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "movieAdmin.do",
				"&order=" + order);

		List<MovieVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());

			map.put("end", page.getEndRow());

			list = movieService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("movieAdmin");
		mav.addObject("count", count);
		mav.addObject("movies", list);
		mav.addObject("page", page.getPage());

		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
