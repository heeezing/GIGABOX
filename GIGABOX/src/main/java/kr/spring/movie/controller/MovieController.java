package kr.spring.movie.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.movie.vo.Review_FavVO;
import kr.spring.movie.vo.Review_ReportVO;
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

	// api 영화 등록
	@RequestMapping("/movie/saveMovies.do")
	@ResponseBody
	public Map<String, String> saveMovies(HttpSession session) throws IOException {

		// ===영화API호출 시작 ===//
		LocalDate currentDate = LocalDate.now();
		LocalDate oneMonthAgo = currentDate.minusMonths(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		// 오늘날짜
		String today = currentDate.format(formatter);
		// 개봉일 시작 ( 오늘날짜 한달전 )
		String OneMonthAgo = oneMonthAgo.format(formatter);
		// movieSeq담기
		List<String> movieseqlist = new ArrayList<>();

		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2"); /*
																														 * URL
																														 */
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=7C19X7UCO798503H925F"); /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("listCount", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /* 출력 갯수 */
		urlBuilder.append(
				"&" + URLEncoder.encode("detail", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* detail 출력여부 */
		urlBuilder.append("&" + URLEncoder.encode("sort", "UTF-8") + "="
				+ URLEncoder.encode("prodYear,1", "UTF-8")); /* 제작년도 정렬 */
		urlBuilder.append("&" + URLEncoder.encode("releaseDts", "UTF-8") + "="
				+ URLEncoder.encode(OneMonthAgo, "UTF-8")); /* 개봉일 시작 */
		urlBuilder.append(
				"&" + URLEncoder.encode("releaseDte", "UTF-8") + "=" + URLEncoder.encode(today, "UTF-8")); /* 개봉일 끝 */
		urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("극영화", "UTF-8"));
		URL url = new URL(urlBuilder.toString());
		System.out.println(url);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;

		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;

		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		System.out.println("=====================");

		List<MovieVO> movielist = new ArrayList<MovieVO>();
		JSONObject jObject = new JSONObject(sb.toString());
		JSONArray array = jObject.getJSONArray("Data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jo = (JSONObject) array.get(i);
			JSONArray jArray = jo.getJSONArray("Result");
			String movieSeq = "";
			String title = "";
			String titleEng = "";
			for (int j = 0; j < jArray.length(); j++) {
				MovieVO vo = new MovieVO();
				JSONObject ko = (JSONObject) jArray.get(j);
				movieSeq = ko.getString("movieSeq");
				title = ko.getString("title");
				titleEng = ko.getString("titleEng");
				vo.setMovieSeq(movieSeq);
				movieseqlist.add(vo.getMovieSeq());
				vo.setM_title(title);
				vo.setM_titleEng(titleEng);

				JSONObject kObject = ko.getJSONObject("directors");
				JSONArray larray = kObject.getJSONArray("director");
				String directorNm = "";
				for (int x = 0; x < larray.length(); x++) {
					if (x > 0)
						directorNm += ", ";
					JSONObject mo = (JSONObject) larray.get(x);
					directorNm = mo.getString("directorNm");
				}
				vo.setM_director(directorNm);

				String nation = ko.getString("nation");
				vo.setM_nation(nation);
				String company = ko.getString("company");
				vo.setM_company(company);

				JSONObject aObject = ko.getJSONObject("plots");
				JSONArray barray = aObject.getJSONArray("plot");
				String plotText = "";
				for (int c = 0; c < barray.length(); c++) {
					if (c > 0)
						plotText += ", ";
					JSONObject eo = (JSONObject) barray.get(c);
					plotText = eo.getString("plotText");
				}
				vo.setM_plot(plotText);

				String runtime = ko.getString("runtime");
				vo.setM_runtime(runtime);
				String rating = ko.getString("rating");
				vo.setM_rating(rating);
				String genre = ko.getString("genre");
				vo.setM_genre(genre);

				JSONObject fObject = ko.getJSONObject("ratings");
				JSONArray garray = fObject.getJSONArray("rating");
				String releaseDate = "";
				for (int h = 0; h < garray.length(); h++) {
					if (h > 0)
						releaseDate += ", ";
					JSONObject io = (JSONObject) garray.get(h);
					String singleReleaseDate = io.getString("releaseDate");
					if (singleReleaseDate.contains("|")) {
						String[] splitDates = singleReleaseDate.split("\\|");
						releaseDate = splitDates[0];
					} else {
						releaseDate = singleReleaseDate;
					}
					break; // 첫 번째 데이터만 처리하고 루프 종료
				}
				vo.setM_opendate2(releaseDate);

				String posters = ko.getString("posters");
				String[] posterUrls = posters.split("\\|"); // |로 분리하여 배열로 저장
				if (posterUrls.length > 0) {
					vo.setM_poster2(posterUrls[0]); // 첫 번째 URL을 저장
				}
				String stlls = ko.getString("stlls");
				String[] stllsUrls = stlls.split("\\|"); // |로 분리하여 배열로 저장
				if (stllsUrls.length > 0) {
					vo.setM_stllimg2(stllsUrls[0]); // 첫 번째 URL을 저장
				}

				JSONObject pObject = ko.getJSONObject("vods");
				JSONArray qarray = pObject.getJSONArray("vod");
				String vodUrl = "";
				for (int r = 0; r < qarray.length(); r++) {
					JSONObject so = (JSONObject) qarray.get(r);
					String singleVodUrl = so.getString("vodUrl");
					if (r == 0) {
						vodUrl = singleVodUrl;
					}

					vo.setM_vod(vodUrl);

					JSONObject zObject = ko.getJSONObject("actors");
					JSONArray xarray = zObject.getJSONArray("actor");
					String actorNm = "";
					for (int y = 0; y < qarray.length(); y++) {
						if (y > 0)
							actorNm += ", ";
						JSONObject wo = (JSONObject) xarray.get(y);
						actorNm += wo.getString("actorNm");
					}
					vo.setM_actor(actorNm);
					movielist.add(vo);
				}
			}
		}
		// ===영화API호출 끝 ===//

		// log.debug("<<무비리스트>> : " + movielist);

		MemberVO user = (MemberVO) session.getAttribute("user");

		Map<String, String> mapJson = new HashMap<String, String>();

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			List<String> existMovieSeq = movieService.getExistingMovieSeqList();
			List<MovieVO> uniqueMovies = movieService.removeDuplicateMovies(movielist, existMovieSeq);
			movieService.saveMovies(uniqueMovies);
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	/* =========================영화 목록=============================== */

	@RequestMapping("/movie/movieList.do")
	public ModelAndView getList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCount(map); // 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 8, 10, "movieList.do",
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
	/* =========================상영예정작 목록=============================== */

	@RequestMapping("/movie/premovieList.do")
	public ModelAndView getPreList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCountPreList(map);// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 8, 10, "premovieList.do",
				"&order=" + order);

		List<MovieVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = movieService.selectPreList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("premovieList");
		mav.addObject("count", count);
		mav.addObject("movies", list);
		mav.addObject("page", page.getPage());

		log.debug("<list :>>" + list);
		log.debug("<page :>>" + page.getPage());

		return mav;
	}

	/* =========================이미지 출력=============================== */
	@RequestMapping("/movie/imageView.do")
	public ModelAndView viewImage(@RequestParam int movie_num, @RequestParam int movie_type) {

		MovieVO movie = movieService.selectMovie(movie_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");

		if (movie_type == 1) {// poster
			mav.addObject("imageFile", movie.getM_poster());
			mav.addObject("filename", movie.getPoster_name());
		} else if (movie_type == 2) {// stllimg
			mav.addObject("imageFile", movie.getM_stllimg());
			mav.addObject("filename", movie.getStllimg_name());
		} else if (movie_type == 3) {// stllimg3
			mav.addObject("imageFile", movie.getM_stllimg3());
			mav.addObject("filename", movie.getStllimg_name3());
		} else if (movie_type == 4) {// stllimg4
			mav.addObject("imageFile", movie.getM_stllimg4());
			mav.addObject("filename", movie.getStllimg_name4());
		} else if (movie_type == 5) {// stllimg5
			mav.addObject("imageFile", movie.getM_stllimg5());
			mav.addObject("filename", movie.getStllimg_name5());
		} else if (movie_type == 6) {// stllimg6
			mav.addObject("imageFile", movie.getM_stllimg6());
			mav.addObject("filename", movie.getStllimg_name6());
		}

		return mav;
	}

	/* =========================영화 상세페이지=============================== */
	@RequestMapping("/movie/movieDetail.do")
	public ModelAndView getDetail(@RequestParam int movie_num) {
		log.debug("<<영화 상세>> : " + movie_num);

		// 글 상세
		MovieVO movie = movieService.selectMovie(movie_num);

		// 제목에 태그를 허용하지 않음
		movie.setM_title(StringUtil.useNoHtml(movie.getM_title()));

		// 내용에 태그 불허
		movie.setM_plot(StringUtil.useBrNoHtml(movie.getM_plot()));

		return new ModelAndView("movieDetail", "movie", movie);
	}

	/* =========================영화 수정=============================== */
	// 수정 폼 호출
	@GetMapping("/movie/movieUpdate.do")
	public String formUpdate(@RequestParam int movie_num, Model model) {
		MovieVO movie = movieService.selectMovie(movie_num);
		movie.setM_title(StringUtil.useNoHtml(movie.getM_title()));
		movie.setM_actor(StringUtil.useNoHtml(movie.getM_actor()));
		movie.setM_titleEng(StringUtil.useNoHtml(movie.getM_titleEng()));
		movie.setM_director(StringUtil.useNoHtml(movie.getM_director()));
		movie.setM_nation(StringUtil.useNoHtml(movie.getM_nation()));
		movie.setM_company(StringUtil.useNoHtml(movie.getM_company()));
		movie.setM_opendate2(StringUtil.useNoHtml(movie.getM_opendate2()));
		movie.setM_rating(StringUtil.useNoHtml(movie.getM_rating()));
		movie.setM_genre(StringUtil.useNoHtml(movie.getM_genre()));
		movie.setM_plot(StringUtil.useNoHtml(movie.getM_plot()));
		
		model.addAttribute("movieVO", movie);

		return "movieUpdate";
	}

	// 전송된 데이터 처리
	@PostMapping("/movie/movieUpdate.do")
	public String submitUpdate(@Valid MovieVO movie, BindingResult result, HttpServletRequest request, Model model) {

		log.debug("<<영화 수정 - MovieVO>> : " + movie);

		// 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) { 
			MovieVO db_movie = movieService.selectMovie(movie.getMovie_num());
		  movie.setPoster_name(db_movie.getPoster_name());
		  movie.setStllimg_name(db_movie.getStllimg_name());
		  
			/*
			 * movie.setStllimg_name3(db_movie.getStllimg_name3());
			 * movie.setStllimg_name4(db_movie.getStllimg_name4());
			 * movie.setStllimg_name5(db_movie.getStllimg_name5());
			 * movie.setStllimg_name6(db_movie.getStllimg_name6());
			 */
		  
		  return "movieUpdate"; 
		 }
		 
		// 글수정
		movieService.updateMovie(movie);

		// view에 표시할 메세지
		model.addAttribute("message", "영화 수정이 완료되었습니다!");
		model.addAttribute("url", request.getContextPath() + "/movie/movieDetail.do?movie_num=" + movie.getMovie_num());

		return "common/resultView";
	}

	/* =========================영화 삭제=============================== */
	@RequestMapping("/movie/movieDelete.do")
	public String delete(@RequestParam int movie_num) {
		log.debug("<<영화 삭제 >> : " + movie_num);

		movieService.deleteMovie(movie_num);
		return "redirect:/movie/movieAdmin.jsp";
	}

	/* =========================영화 상영 종료=============================== */
	@RequestMapping("/movie/movieUpdateStatus.do")
	public String updateStatus(@RequestParam int movie_num) {
		log.debug("<<영화 상영종료 >> : " + movie_num);

		movieService.updateStatusMovie(movie_num);
		return "redirect:/movie/movieAdmin.jsp";
	}

	@RequestMapping("/movie/moviecheckUpdateStatus.do")
	@ResponseBody
	public Map<String, String> updateStatusMovieCheck(@RequestParam String selectmovies, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		Map<String, String> mapJson = new HashMap<String, String>();

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			String[] Selectmovies = selectmovies.split(",");
			movieService.updateStatusMovieCheck(Selectmovies);

			mapJson.put("result", "success");
		}

		return mapJson;
	}

	/* =========================영화 예매 순위 구하기=============================== */
	@RequestMapping("/movie/reservationRankByMovie.do")
	@ResponseBody
	public Map<String, Object> getRank(Integer movie_num) {
		int rank = movieService.reservationRankByMovie(movie_num);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		log.debug("<<rank값? : >>" + rank);
		log.debug("<<movie_num값? : >>" + movie_num);

		mapJson.put("rank", rank);

		return mapJson;
	}

	/* =========================관리자=============================== */
	@RequestMapping("/movie/movieAdmin.do")
	public ModelAndView getadminList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCountAdminList(map);// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 10, "movieAdmin.do",
				"&order=" + order);

		List<MovieVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());

			map.put("end", page.getEndRow());

			list = movieService.selectAdminList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("movieAdmin");
		mav.addObject("count", count);
		mav.addObject("movies", list);
		mav.addObject("page", page.getPage());

		return mav;
	}

	// 관람평
	// 예매한 내역만 등록할 수 있게 수정해야해
	/* =========================관람평 글 등록=============================== */
	@RequestMapping("/movie/reviewWrite.do")
	@ResponseBody
	public Map<String, String> writeReview(ReviewVO reviewVO, HttpSession session, HttpServletRequest request) {
		log.debug("<<관람평 작성>> : " + reviewVO);

		Map<String, String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			// 회원번호 등록
			reviewVO.setMem_num(user.getMem_num());
			// 관람평 등록
			movieService.insertReview(reviewVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}

	/* =========================관람평 글 목록============================== */
	@RequestMapping("/movie/reviewList.do")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "rowCount", defaultValue = "10") int rowCount, @RequestParam int movie_num,
			HttpSession session) {
		log.debug("<<currentPage>> : " + currentPage);
		log.debug("<<board_num>> : " + movie_num);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movie_num", movie_num);

		MemberVO user = (MemberVO) session.getAttribute("user");

		// 전체 레코드 수
		int count = movieService.selectRowCountReview(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 1, null);

		List<ReviewVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = movieService.selectListReview(map);
		} else {
			list = Collections.emptyList();
		}

		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		// 로그인 한 회원정보 세팅
		if (user != null) {
			mapJson.put("user_num", user.getMem_num());
		}

		return mapJson;
	}

	/* =========================관람평 평점 매기기=============================== */
	@RequestMapping("/movie/reviewAvg.do")
	@ResponseBody
	public Map<String, Object> AvgReview(int movie_num) {
		int ratingAvg = movieService.averageRatingScore(movie_num);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		log.debug("<<rating_avg값? : >>" + ratingAvg);
		log.debug("<<movie_num값? : >>" + movie_num);

		mapJson.put("ratingAvg", ratingAvg);

		return mapJson;
	}

	/* =========================관람평 글 개수 세기=============================== */
	@RequestMapping("/movie/reviewCount.do")
	@ResponseBody
	public Map<String, Object> CountReview(Integer movie_num) {
		int reviewCount = movieService.selectReviewCount(movie_num);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		log.debug("<<reviewcnt값? : >>" + reviewCount);
		log.debug("<<movie_num값? : >>" + movie_num);

		mapJson.put("reviewCount", reviewCount);

		return mapJson;
	}

	/* =========================관람평 삭제=============================== */
	@RequestMapping("/movie/reviewDelete.do")
	@ResponseBody
	public Map<String, String> deleteReply(@RequestParam int review_num, HttpSession session) {
		log.debug("<<review_num>> : " + review_num);

		Map<String, String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		ReviewVO db_review = movieService.selectReview(review_num);
		if (user == null) {
			// 로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		} else if (user != null && user.getMem_num() == db_review.getMem_num()) {
			// 로그인한 회원번호와 작성자 회원번호 일치
			movieService.deleteReview(review_num);
			mapJson.put("result", "success");
		} else {
			// 로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}

		return mapJson;
	}

	/* =========================관람평 삭제(관리자)=============================== */
	/*
	 * @RequestMapping("/movie/reviewDeleteAdmin.do")
	 * 
	 * @ResponseBody public Map<String,String> deleteReplyAdmin(@RequestParam int
	 * review_num, HttpSession session){ log.debug("<<리뷰 삭제 review_num>> : " +
	 * review_num);
	 * 
	 * Map<String,String> mapJson = new HashMap<String,String>(); MemberVO user =
	 * (MemberVO)session.getAttribute("user"); if(user==null) { //로그인이 되지 않은 경우
	 * mapJson.put("result", "logout"); }else if(user!=null) {
	 * movieService.deleteReview(review_num); mapJson.put("result", "success"); }
	 * return mapJson; }
	 */
	/* =========================관람평 삭제(관리자)=============================== */
	@RequestMapping("/movie/reviewDeleteAdmin.do")
	public String deleteReviewAdmin(@RequestParam int review_num) {
		log.debug("<<관람평 삭제 >> : " + review_num);

		movieService.deleteReview(review_num);
		return "redirect:/movie/reportAdmin.do";
	}

	/* =========================관람평 수정=============================== */
	@RequestMapping("/movie/reviewUpdate.do")
	@ResponseBody
	public Map<String, String> modifyReply(ReviewVO reviewVO, HttpSession session, HttpServletRequest request) {
		log.debug("<<ReviewVO>> : " + reviewVO);

		Map<String, String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		ReviewVO db_review = movieService.selectReview(reviewVO.getReview_num());
		if (user == null) { // 로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		} else if (user != null && user.getMem_num() == db_review.getMem_num()) {
			// 로그인 회원번호와 작성자 회원번호가 일치
			// 관람평 수정
			movieService.updateReview(reviewVO);
			mapJson.put("result", "success");
		} else {
			// 로그인 회원번호와 작성자 회원번호가 불일치
			mapJson.put("result", "wrongAccess");
		}

		return mapJson;
	}

	/* =========================관람평 좋아요=============================== */
	// 부모글 좋아요 읽기
	@RequestMapping("/movie/getFav.do")
	@ResponseBody
	public Map<String, Object> getFav(Review_FavVO fav, HttpSession session) {
		log.debug("<<관람평 좋아요 읽기>> : " + fav);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("status", "noFav");
		} else {
			// 로그인 된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			Review_FavVO reviewFav = movieService.selectFav(fav);
			if (reviewFav != null) {
				mapJson.put("status", "yesFav");
			} else {// 등록한 좋아요가 없으면 등록
				mapJson.put("status", "noFav");
			}
			mapJson.put("count", movieService.selectFavCount(fav));
		}
		log.debug("<<관람평 좋아요 읽기>> : " + fav);
		return mapJson;
	}

	// 부모글 좋아요 등록 / 삭제
	@RequestMapping("/movie/writeFav.do")
	@ResponseBody
	public Map<String, Object> writeFav(Review_FavVO fav, HttpSession session) {
		log.debug("<<관람평 좋아요 등록/삭제 - Review_FavVO>> : " + fav);

		Map<String, Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			// 로그인 된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			Review_FavVO reviewFav = movieService.selectFav(fav);
			if (reviewFav != null) {// 등록한 좋아요가 있으면 삭제
				movieService.deleteFav(reviewFav.getReview_favnum());

				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			} else {// 등록한 좋아요가 없으면 등록
				movieService.insertFav(fav);

				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", movieService.selectFavCount(fav));
		}
		return mapJson;
	}

	/* =========================신고 등록=============================== */
	@RequestMapping("/movie/writeReport.do")
	@ResponseBody
	public Map<String, Object> writeReport(Review_ReportVO repoVO, HttpSession session,
			@RequestParam(value = "review_num") int review_num, @RequestParam(value = "movie_num") int movie_num) {
		log.debug("<<관람평 신고 작성>> : " + repoVO);

		MemberVO user = (MemberVO) session.getAttribute("user");
		int mem_num = user.getMem_num();
		int hasReported = movieService.selectCountReportByUser(mem_num, review_num);
		log.debug("<<신고 count 횟수>> : " + hasReported);
		log.debug("<<mem_num ? >> : " + mem_num);
		log.debug("<<review_num ? >> : " + review_num);

		Map<String, Object> mapJson = new HashMap<String, Object>();
		if (user == null) {
			mapJson.put("result", "logout");
		} else if (user != null && hasReported > 0) {
			mapJson.put("result", "alreadydonereport");
		} else {
			// 회원번호 등록
			repoVO.setMem_num(user.getMem_num());
			repoVO.setReview_num(review_num);
			repoVO.setMovie_num(movie_num);
			// 관람평 등록
			movieService.insertRepo(repoVO);
			mapJson.put("result", "success");
		}

		return mapJson;
	}

	/* =========================신고 목록============================== */
	@RequestMapping("/movie/reportAdmin.do")
	public ModelAndView getRepoList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "order", defaultValue = "1") int order, String keyfield, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		// 전체/검색 레코드 수
		int count = movieService.selectRowCountRepo(map);
		log.debug("count의 값: " + count);

		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 10, "reportAdmin.do");

		List<Review_ReportVO> list = null;
		if (count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = movieService.selectListRepo(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("reportAdmin");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());

		log.debug("<<관람평 신고목록>> : " + list);

		return mav;
	}

	/* ========================관람평(신고) 상세=============================== */
	@RequestMapping("/movie/reviewDetail.do")
	public String getReviewDetail(@RequestParam int review_num, Model model) {
		log.debug("<<관람평 상세>> : " + review_num);

		// 글 상세
		ReviewVO reviewVO = movieService.selectReview(review_num);

		// 내용에 태그 불허
		reviewVO.setReview_content(StringUtil.useBrNoHtml(reviewVO.getReview_content()));

		reviewVO.setId(reviewVO.getId());
		reviewVO.setM_title(reviewVO.getM_title());
		model.addAttribute("review", reviewVO);

		return "reviewDetail";
	}

	/* =========================신고 삭제=============================== */
	@RequestMapping("/movie/repoDelete.do")
	public String deleteRepo(@RequestParam int repo_num) {
		log.debug("<<관람평 신고목록 삭제 >> : " + repo_num);

		movieService.deleteRepo(repo_num);
		return "redirect:/movie/reportAdmin.jsp";
	}

	@RequestMapping("/movie/repocheckDelete.do")
	@ResponseBody
	public Map<String, String> submitDeleterepoChex(@RequestParam String selectreports, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		Map<String, String> mapJson = new HashMap<String, String>();

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			String[] Selectreports = selectreports.split(",");
			movieService.deleteRepoCheck(Selectreports);

			mapJson.put("result", "success");
		}

		return mapJson;
	}

	/*
	 * ======================= 직접 등록한 포스터 출력 =======================
	 */
	// 프로필 사진 출력(회원번호 지정)
	@RequestMapping("/movie/photoView.do")
	public String getPosterByMovienum(@RequestParam int movie_num, HttpServletRequest request, Model model) {
		MovieVO movieVO = movieService.selectMovie(movie_num);
		viewProfile(movieVO, request, model);

		return "imageView";
	}

	// 프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MovieVO movieVO, HttpServletRequest request, Model model) {
		model.addAttribute("imageFile", movieVO.getM_poster());
		model.addAttribute("filename", movieVO.getPoster_name());
		model.addAttribute("imageFile2", movieVO.getM_stllimg());
		model.addAttribute("filename2", movieVO.getStllimg_name());
		model.addAttribute("imageFile3", movieVO.getM_stllimg3());
		model.addAttribute("filename3", movieVO.getStllimg_name3());
		model.addAttribute("imageFile4", movieVO.getM_stllimg4());
		model.addAttribute("filename4", movieVO.getStllimg_name4());
		model.addAttribute("imageFile5", movieVO.getM_stllimg5());
		model.addAttribute("filename5", movieVO.getStllimg_name5());
		model.addAttribute("imageFile6", movieVO.getM_stllimg6());
		model.addAttribute("filename6", movieVO.getStllimg_name6());
	}
}
