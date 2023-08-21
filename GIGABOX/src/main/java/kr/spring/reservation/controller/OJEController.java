package kr.spring.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.reservation.service.ReservationService;
import kr.spring.reservation.vo.ReservationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OJEController {
	@Autowired
	private ReservationService reservationService;
	
	/*========================
	 *  자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public ReservationVO initCommand() {
		return new ReservationVO();
	}
	
	/*========================
	 * 결제 완료 페이지
	 *========================*/
	@GetMapping("/reservation/payment_success.do")
	public String paySuccessForm(@RequestParam("res_num") String res_num, Model model) {
	    
	    ReservationVO reservationVO = reservationService.selectRes(res_num);
	    model.addAttribute("reservationVO", reservationVO);
	    
		return "payment_success";
	}
}
