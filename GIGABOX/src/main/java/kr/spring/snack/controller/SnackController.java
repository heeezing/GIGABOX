package kr.spring.snack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SnackController {
	@Autowired
	private SnackService snackService;
	
	/*======================
		   자바빈 초기화
	======================*/
	@ModelAttribute
	public SnackVO initCommand() {
		return new SnackVO();
	}

	
	/*======================
		 	스낵 목록
	======================*/	
	
	@RequestMapping("/snack/list.do")
	public ModelAndView getList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("snackList");
		
		return mav;
}
	
	
	
}
