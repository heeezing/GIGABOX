package kr.spring.reservation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.vo.MemberVO;
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
	
	// 선택한 좌석 데이터 저장
	@GetMapping("/reservation/saveSeats.do")
	public String saveSeats(@RequestParam("seats") String seats, @RequestParam int sch_num, HttpSession session) {
		session.setAttribute("clickedSeats", seats);
		session.setAttribute("sch_num", sch_num);
		return "redirect:/reservation/pay.do";
	}
	
	/*===============
	 * 예매 결제
	 *===============*/
	// 예매 결제 폼 호출
	@GetMapping("/reservation/pay.do")
    public String formPay(HttpSession session, Model model) {
        String clickedSeats = (String) session.getAttribute("clickedSeats");
        int sch_num = (int)session.getAttribute("sch_num");
        
        ScheduleVO scheduleVO = reservationService.selectSchedule(sch_num);
        model.addAttribute("scheduleVO", scheduleVO);
        model.addAttribute("clickedSeats", clickedSeats);
        
        return "reservationPay";
    }
	
	
	
	
}
