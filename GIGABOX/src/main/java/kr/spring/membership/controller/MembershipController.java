package kr.spring.membership.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.membership.service.MembershipService;
import kr.spring.membership.vo.MembershipVO;
import kr.spring.msorder.vo.MembershipOrderVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipController {
	@Autowired
	private MembershipService membershipService;
	
	/*=======================
	 * 자바빈 초기화
	 *=======================*/
	@ModelAttribute
	public MembershipVO initCommand() {
		return new MembershipVO();
	}
	/*--------------------
	 * 멤버십 목록
	 *--------------------*/
	@RequestMapping("/membership/membership_list.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();

		//전체/검색 레코드수
		int count = membershipService.selectMembershipCount(map);

		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,20,10,"membership_list.do");

		List<MembershipVO> list = null;
		if(count > 0) {
			map.put("start",page.getStartRow());
			map.put("end", page.getEndRow());

			list = membershipService.selectMembershipList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("membershipList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());

		return mav;
	}

	//이미지 출력
	@RequestMapping("/membership/imageView.do")
	public ModelAndView viewImage(@RequestParam int membership_id) {

		MembershipVO membershipVO = membershipService.selectMembership(membership_id);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");

		
		mav.addObject("imageFile", membershipVO.getPhoto());
		mav.addObject("filename", membershipVO.getPhoto_name());
		

		return mav;
	}
	

}













