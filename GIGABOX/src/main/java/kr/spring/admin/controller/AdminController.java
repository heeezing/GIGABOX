package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	/*=================================
	 * 회원관리 - 관리자
	 *=================================*/	
	@RequestMapping("/member/admin_list.do")
	public ModelAndView getList(
			@RequestParam(value="pageNum",
			            defaultValue="1") int currentPage,
			             String keyfield,String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = adminService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,currentPage,
						count,20,10,"admin_list.do");
		
		List<MemberVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = adminService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_memberList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	@RequestMapping("/main/admin.do")
	public String adminMain(Model model) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 5);
		
		List<MemberVO> memberList = adminService.selectList(map);
		
		//최신 5명 회원정보
		model.addAttribute("memberList", memberList);
		
		return "admin";//타일스 설정의 식별자
	}
	
	
	/*=================================
	 * 영화관리 - 관리자
	 *=================================*/
	
	
	/*=================================
	 * 극장관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 상영관 관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 상영시간표 관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 예매관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 스토어 관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 주문관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 포인트 내역 - 관리자
	 *=================================*/
	
	/*=================================
	 * 신고관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 멤버십관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 이벤트관리 - 관리자
	 *=================================*/
	
	/*=================================
	 * 고객센터? - 관리자
	 *=================================*/
	
	
	
}
