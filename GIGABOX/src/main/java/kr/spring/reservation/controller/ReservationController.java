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
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.order.service.OrderService;
import kr.spring.point.service.PointService;
import kr.spring.point.vo.PointVO;
import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.service.TheaterService;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReservationController {
	@Autowired
	private ReservationService resService;
	@Autowired
	private PointService pointService;
	@Autowired
	private TheaterService theaterService;
	@Autowired
	private OrderService orderService;
	
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
		
		// 상영관 좌석수 불러오기
		int seat = resService.selectSeats(scheduleVO.getHall_num());
		scheduleVO.setRemain(seat); // 남은 좌석수 셋팅
		log.debug("<<seat>> : " + seat);
		log.debug("<<scheduleVO>> : " + scheduleVO);
		
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
	@RequestMapping("/reservation/getScheduleList.do")
	@ResponseBody
	public Map<String,Object> getScheduleList(@RequestParam("movie_num") int movie_num, @RequestParam("th_num") int th_num, @RequestParam("sch_date") String sch_date, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movie_num", movie_num);
		map.put("th_num", th_num);
		map.put("sch_date", sch_date);
		
		List<ScheduleVO> list = resService.getScheduleList(map);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("list", list);
		
		//====로그인 한 회원정보 셋팅====
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
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
	
	/*===============
	 * 상영시간표
	 *===============*/
	@RequestMapping("/reservation/schedule.do")
	public ModelAndView getChoiceList() {
		List<TheaterVO> list = theaterService.selectTheaterList();
		List<Date> dateList = getDate();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("schedule");
		mav.addObject("list", list);
		
		mav.addObject("dateList", dateList);
		
		return mav;
	}
	
	/*===============
	 * 좌석 선택
	 *===============*/
	// 좌석 선택 폼 호출
	@GetMapping("/reservation/seat.do")
	public String formSeat(@RequestParam int sch_num,Model model) {
		ScheduleVO scheduleVO = resService.selectSchedule(sch_num);
		List<String> seatsDB = resService.getSeatsDB(sch_num);
		
		model.addAttribute("scheduleVO",scheduleVO);
		model.addAttribute("seatsDB",seatsDB);
		
		return "seat";
	}
	
	
	/*===============
	 * 예매 결제
	 *===============*/
	// 예매 결제 폼
	@RequestMapping("/reservation/pay.do")
    public String formPay(@RequestParam int sch_num, Model model, ReservationVO reservationVO,HttpSession session) {
        log.debug("<<reservationVO>> : " + reservationVO);
        
        ScheduleVO scheduleVO = resService.selectSchedule(sch_num);
        
        // 회원 정보 읽어오기
        MemberVO user = (MemberVO)session.getAttribute("user");
        log.debug("<<user>> : " + user);
        
        // 회원 포인트
        int totalPoint = pointService.myTotalPoint(user.getMem_num());
        log.debug("<<totalPoint>> : " + totalPoint);
        
        // 예약번호 미리 생성
        String res_num = resService.selectResNum();
        
        model.addAttribute("res_num", res_num);
        model.addAttribute("scheduleVO", scheduleVO);
        model.addAttribute("have_point", totalPoint); // 사용가능 포인트
        
        return "reservationPay";
    }
	// 전송된 데이터 처리
	@PostMapping("/reservation/reservation.do")
	public String submit(@RequestParam String res_num,ReservationVO reservationVO,BindingResult result,HttpServletRequest request,HttpSession session, Model model) {
		// 회원 정보 읽어오기
        MemberVO user = (MemberVO)session.getAttribute("user");
        log.debug("<<res_num>> : " + res_num);
        
        reservationVO.setMem_num(user.getMem_num()); // 회원번호 셋팅
        
        int sch_num = reservationVO.getSch_num();
        
        //전송된 데이터 유효성 체크 결과, 오류 있으면 폼을 다시 호출
		/*
		 * if(result.hasErrors()) { return formPay(sch_num, model, reservationVO,
		 * session); }
		 */
        
        // 상영시간표 정보 호출
        ScheduleVO scheduleVO = resService.selectSchedule(sch_num);
        log.debug("<<schedule>> : " + scheduleVO);
        
        //회원 멤버십 정보 확인
		String membership = orderService.selectMembershipByMem_num(user.getMem_num());
		//멤버십에 따른 적립포인트 계산
		int add_point = 0; // 적립포인트
		int final_total = reservationVO.getRes_total(); // 최종 금액
		if(membership == "bronze") {
			add_point = (int) (final_total * 0.05);
		}else if(membership == "silver") {
			add_point = (int) (final_total * 0.07);
		}else if(membership == "gold") {
			add_point = (int) (final_total * 0.1);
		}else {
			add_point = (int) (final_total * 0.03);
		}
		
		reservationVO.setAdd_point(add_point); // 적립 포인트 셋팅
		reservationVO.setM_title(scheduleVO.getM_title());
		
        resService.insertRes(reservationVO);
        
        ReservationVO reservation = resService.selectRes(res_num);
	    model.addAttribute("reservation", reservation);
	    model.addAttribute("add_point", add_point);
	    
	    log.debug("<<reservation>> : " + reservation);
		
		return "payment_success";
	}
	
	/*========================
	 *  예매 취소
	 *========================*/
	@RequestMapping("/reservation/deleteRes.do")
	@ResponseBody
	public Map<String,String> DeleteRes(@RequestParam String res_num,HttpSession session,HttpServletRequest request,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		log.debug("<<res_num>> : " + res_num);
		
		if(user == null) { // 로그인 X
			mapAjax.put("result","logout");
		}else { // 로그인 O
			// 취소 주문 건의 적립, 사용 포인트 조회
			PointVO db_point = pointService.selectResCancelPoint(res_num);
			int db_use_point = db_point.getUse_point();
			int db_add_point = db_point.getAdd_point();
			
			log.debug("<<db_point>> : " + db_point);
			log.debug("<<db_use_point>> : " + db_point);
			log.debug("<<db_add_point>> : " + db_point);
			
			// 현재 내 포인트 조회
			int my_point = pointService.myTotalPoint(db_point.getMem_num());
			if(my_point + db_use_point < db_add_point) {
				mapAjax.put("result", "shortage");
			}else {
				// 사용 포인트는 환불, 적립 포인트는 차감
				PointVO pointVO = new PointVO();
				pointVO.setAdd_point(db_use_point);
				pointVO.setUse_point(db_add_point);
				pointVO.setRes_num(res_num);
				pointVO.setMem_num(db_point.getMem_num());
				
				// 예매 취소 처리
				resService.deleteRes(res_num);
				pointService.insertResRefundPoint(pointVO);
				
				mapAjax.put("result","success");
			}
		}
		return mapAjax;
	}
	
	/*========================
	 *  회원 예매 내역 목록
	 *========================*/
	@RequestMapping("/reservation/admin_resList.do")
	public ModelAndView getResList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, @RequestParam(value="order", defaultValue="1") int order, String keyfield, String keyword){
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = resService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 10, "admin_resList.do", "&order="+order);
		
		List<ReservationVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = resService.selectResList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_resList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*========================
	 *  예매 취소 - 관리자
	 *========================*/
	@RequestMapping("/reservation/deleteResByAdmin.do")
	public String DeleteResByAdmin(@RequestParam String res_num,HttpServletRequest request,Model model) {
		resService.deleteRes(res_num);
		
		model.addAttribute("message", "예매가 취소되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/reservation/admin_resList.do");
		
		return "common/resultView";
		
	}
}
