package kr.spring.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ReservationVO;
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
	
	/*========================
	 *  상영시간표 등록
	 *========================*/
	//등록 폼
	@GetMapping("/reservation/quick_res.do")
	public String form() {
		return "quick_res";
	}
}
