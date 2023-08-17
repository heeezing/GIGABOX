package kr.spring.reservation.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.hall.vo.HallVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReservationController {
	@Autowired
	private ReservationService resService;
	
	/*========================
	 *  자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public ReservationVO initCommand() {
		return new ReservationVO();
	}
	@ModelAttribute
	public ScheduleVO InitCommand() {
		return new ScheduleVO();
	}
	
	/*========================
	 *  빠른 예매
	 *========================*/
	//빠른예매
	@RequestMapping("/reservation/quick_res.do")
	public ModelAndView form() {
		// 영화 정보 불러오기
		List<MovieVO> movieList = resService.getMovieList();
		//model.addAttribute("MovieList", resService.getMovieList());

		// 극장 정보 불러오기
		List<TheaterVO> theaterList = resService.getTheaterList();
		//model.addAttribute("TheaterList", resService.getTheaterList());
		
		// 날짜
		List<Date> dateList = getDate(); 
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("quick_res");
		
		mav.addObject("movieList", movieList);
		mav.addObject("theaterList", theaterList);
		mav.addObject("dateList", dateList);
		
		return mav;
	}
	
	/*========================
	 *  상영 시간표 등록
	 *========================*/
	//등록 폼
	@GetMapping("reservation/admin_scheduleAdd.do")
	public String formSchedule(Model model) {
		// 영화 정보 불러오기
		model.addAttribute("MovieList", resService.getMovieList());
		// 극장 정보 불러오기
		model.addAttribute("TheaterList", resService.getTheaterList());
		return "admin_scheduleAdd";
	}
	//전송된 데이터 처리
	@PostMapping("/reservation/admin_scheduleAdd.do")
	public String submitSchedule(@Valid ScheduleVO scheduleVO, BindingResult result,HttpServletRequest request,HttpSession session,Model model) {
		log.debug("<<상영시간표 등록>> : " + scheduleVO);
		
		//글쓰기
		resService.insertSchedule(scheduleVO);
		
		model.addAttribute("message", "상영시간표 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/reservation/admin_schedule.do");
		
		return "common/resultView";
	}
	// 상영관 정보
	@RequestMapping("/reservation/getHallsByTheaterId")
	@ResponseBody
	public List<HallVO> getHallsByTheaterId(@RequestParam("th_num") int th_num) {
	    return resService.getHallsByTheaterId(th_num);
	}
	//상영시간표 정보
	@RequestMapping("/reservation/getScheduleList")
	@ResponseBody
	public Map<String,Object> getScheduleList(@RequestParam("movie_num") int movie_num, @RequestParam("th_num") int th_num){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movie_num", movie_num);
		map.put("th_num", th_num);
		
		List<ScheduleVO> list = resService.getScheduleList(map);
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("list", list);
		
		return mapJson;
	}

	
	/*========================
	 *  상영 시간표 목록
	 *========================*/
	@RequestMapping("/reservation/admin_schedule.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, @RequestParam(value="order", defaultValue="1") int order, String keyfield, String keyword) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = resService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "list.do", "&order="+order);
		
		List<ScheduleVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = resService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_schedule");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*========================
	 *  상영 시간표 수정
	 *========================*/
	// 수정 폼 호출
	@GetMapping("reservation/admin_scheduleUpdate.do")
	public String formScheduleUpdate(@RequestParam int sch_num, Model model) {
	    ScheduleVO scheduleVO = resService.selectSchedule(sch_num);
	    model.addAttribute("scheduleVO", scheduleVO);
	    model.addAttribute("MovieList", resService.getMovieList());
	    model.addAttribute("TheaterList", resService.getTheaterList());
	    return "admin_scheduleUpdate"; // 수정 폼 페이지로 이동
	}
	//전송된 데이터 처리
	@PostMapping("reservation/admin_scheduleUpdate.do")
	public String submitScheduleUpdate(@Valid ScheduleVO scheduleVO, BindingResult result, HttpServletRequest request, Model model) {
		log.debug("<<상영시간표 수정 - ScheduleVO>>" + scheduleVO);
		
		resService.updateSchedule(scheduleVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "상영시간표 수정 완료!");
		model.addAttribute("url", request.getContextPath()+"/reservation/admin_schedule.do");
		
		return "common/resultView";
	}
	
	/*========================
	 *  상영 시간표 삭제
	 *========================*/
	@RequestMapping("/reservation/admin_scheduleDelete.do")
	public String submitScheduleDelete(@RequestParam int sch_num) {
		log.debug("<<상영시간표 삭제 - sch_num>> : " + sch_num);
		
		//상영시간표 삭제
		resService.deleteSchedule(sch_num);
		
		return "redirect:/reservation/admin_schedule.do";
	}
	
	/*===============
	 * 날짜 선택
	 *===============*/
	public List<Date> getDate(){
		
		Date now = new Date();
        List<Date> dateList = new ArrayList<>();

        // Calendar 객체를 사용하여 오늘 날짜를 설정
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 오늘 날짜부터 14일 후까지의 날짜를 리스트에 추가
        for (int i=0; i<14; i++) {
        	dateList.add(calendar.getTime());
            calendar.add(Calendar.DAY_OF_MONTH, 1); // 하루를 더함
        }
        
		return dateList;
	}
	
	/*========================
	 * 결제 완료 페이지
	 *========================*/
	@RequestMapping("/reservation/payment_success.do")
	public String paySuccessForm() {
		return "payment_success";
	}
}
