package kr.spring.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SeatController {
	@Autowired
	private ReservationService reservationService;
	
	
	/*===============
	 * 좌석 선택
	 *===============*/
	// 좌석 선택 폼 호출
	@GetMapping("/reservation/seat.do")
	public String formSeat(@RequestParam int sch_num,Model model) {
		ScheduleVO scheduleVO = reservationService.selectSchedule(sch_num);
		model.addAttribute("scheduleVO",scheduleVO);
		
		return "seat";
	}
	
	
	
	
}
