package kr.spring.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.boot.model.relational.InitCommand;
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
import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.reservation.vo.ScheduleVO;
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
	@GetMapping("/reservation/quick_res.do")
	public String form() {
		return "quick_res";
	}
	//좌석 선택
	@GetMapping("/reservation/seat.do")
	public String formSeat() {
		return "seat";
	}
	
	/*========================
	 *  상영 시간표 등록
	 *========================*/
	//등록 폼
	@GetMapping("reservation/admin_scheduleAdd.do")
	public String formSchedule() {
		return "admin_scheduleAdd";
	}
	//전송된 데이터 처리
	@PostMapping("/reservation/admin_scheduleAdd.do")
	public String submitSchedule(@Valid ScheduleVO scheduleVO, BindingResult result,HttpServletRequest request,HttpSession session,Model model) {
		log.debug("<<상영시간표 등록>> : " + scheduleVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return formSchedule();
		}
		
		//글쓰기
		resService.insertSchedule(scheduleVO);
		
		model.addAttribute("message", "상영시간표 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/reservation/admin_schedule.do");
		
		return "common/resultView";
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
}
