package kr.spring.membership.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.membership.service.MembershipService;
import kr.spring.membership.vo.MembershipVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MembershipController {
	@Autowired
	private MembershipService membershipService;
	
	@ModelAttribute
	public MembershipVO initCommand() {
		return new MembershipVO();
	}
	/*=================================
	 * 멤버십목록
	 *=================================*/
	@RequestMapping("/membership/membership_list.do")
	public ModelAndView getList(
			@RequestParam(value="pageNum", defaultValue="1")
			int currentPage, String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = membershipService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,currentPage,
								count,20,10,"membershiplist.do");
		
		List<MembershipVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = membershipService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("membershipList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;		
	
	}
}













