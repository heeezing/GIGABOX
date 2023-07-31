package kr.spring.membership.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.membership.service.MembershipService;
import kr.spring.membership.vo.MembershipVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipController {
	@Autowired
	private MembershipService memershipService;
	
	/*=======================
	 * 자바빈 초기화
	 *=======================*/
	@ModelAttribute
	public MembershipVO initCommand() {
		return new MembershipVO();
	}
	/*=======================
	 * 멤버십 등록
	 *=======================*/
	//멤버십 등록 폼 호출
	@GetMapping("/membership/registerMembership.do")
	public String form() {
		return "membershipRegister";
	}
	
}
