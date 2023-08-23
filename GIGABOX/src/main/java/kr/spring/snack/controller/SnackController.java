package kr.spring.snack.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cart.service.CartService;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.service.OrderService;
import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SnackController {
	@Autowired
	private SnackService snackService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
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
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="sn_category",defaultValue="0") int sn_category,
								HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		int cartCount = 0;
		int giftCount = 0;
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) { //로그인 O
			cartCount = cartService.selectCartCount(user.getMem_num());
			Map<String,Object> g_map = new HashMap<String,Object>();
			g_map.put("to_id", user.getId());
			giftCount = orderService.selectGiftCountByTo_id(g_map);
		}
		
		//전체or검색 레코드 수
		int count = snackService.selectUserSnackCount(sn_category);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,12,10,"list.do","&sn_category="+sn_category);
		
		//목록 읽어오기
		List<SnackVO> list = null;
		if(count > 0) {
			map.put("sn_category", sn_category);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("sn_status", 1);
			list = snackService.selectUserSnackList(map);
			log.debug("<<목록>> : " + list);
		}
		
		//뷰에서 사용할 수 있도록 데이터 넣어놓기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("snackList"); //tiles 설정
		mav.addObject("count", count);
		mav.addObject("cartCount", cartCount); 
		mav.addObject("giftCount", giftCount); 
		mav.addObject("list", list);
		mav.addObject("sn_category", sn_category);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	/*======================
	   	    이미지 출력
	======================*/	
	
	@RequestMapping("/snack/imageView.do")
	public ModelAndView viewImage(@RequestParam int sn_num) {
		SnackVO snackVO = snackService.selectSnack(sn_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		mav.addObject("imageFile", snackVO.getSn_photo());
		mav.addObject("filename", snackVO.getSn_photo_name());
		
		return mav;
	}
	
	
	
	/*======================
	 		스낵 상세
	======================*/	
	
	@RequestMapping("/snack/detail.do")
	public String getDetail(@RequestParam int sn_num, Model model) {
		log.debug("<<상품 상세 - sn_num>> : " + sn_num);
		
		SnackVO snackVO = snackService.selectSnack(sn_num);
		
		/*태그를 허용X ?
		snack.setSn_name(StringUtil.useNoHtml(snack.getSn_name()));
		snack.setSn_detail(StringUtil.useNoHtml(snack.getSn_detail()));
		snack.setSn_info(StringUtil.useBrNoHtml(snack.getSn_info()));
		*/
		model.addAttribute("snack", snackVO);
		
		return "snackDetail";
	}

	
}
