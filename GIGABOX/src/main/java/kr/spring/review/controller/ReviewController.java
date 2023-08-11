package kr.spring.review.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.review.service.ReviewService;
import kr.spring.review.vo.ReviewVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	/*==============================
	 * 자바빈(VO) 초기화
	 *=============================*/
	@ModelAttribute
	public ReviewVO initCommand() {
		return new ReviewVO();
	}

	/*==============================
	 * 관람평 글 등록  -  예매한 내역만 관람평 남길 수 있게 수정해야해! 
	 *=============================*/
	@RequestMapping("/review/reviewWrite.do")
	@ResponseBody
	public Map<String,String> writeReview(ReviewVO reviewVO, HttpSession session, HttpServletRequest request){
		log.debug("<<관람평 작성>> : " + reviewVO);
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result","logout");
		}else {
			//회원번호 등록
			reviewVO.setMem_num(user.getMem_num());
			//관람평 등록
			reviewService.insertReview(reviewVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*==============================
	 * 관람평 글 목록
	 *=============================*/
	@RequestMapping("/review/reviewList.do")
	@ResponseBody
	public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, @RequestParam(value="rowCount",defaultValue="10") int rowCount, @RequestParam int movie_num, HttpSession session){
		log.debug("<<currentPage>> : " + currentPage);
		log.debug("<<board_num>> : " + movie_num);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("movie_num", movie_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//전체 레코드 수 
		int count = reviewService.selectRowCountReview(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);
		
		List<ReviewVO> list = null;
		if(count > 0) {
			map.put("start",page.getStartRow());
			map.put("end", page.getEndRow());
			list = reviewService.selectList(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		//로그인 한 회원정보 세팅
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
