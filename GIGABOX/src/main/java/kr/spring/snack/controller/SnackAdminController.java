package kr.spring.snack.controller;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.snack.service.SnackService;
import kr.spring.snack.vo.SnackVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SnackAdminController {
	@Autowired
	private SnackService snackService;
	
	/*======================
	 		스낵 목록	
	======================*/
	
	@RequestMapping("/snack/admin_list.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체or검색 레코드 수
		int count = snackService.selectSnackCount(map);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,
										 20,10,"admin_list.do","&order="+order);
		
		//목록 읽어오기
		List<SnackVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = snackService.selectSnackList(map);
			log.debug("<<목록>> : " + list);
		}
		
		//뷰에서 사용할 수 있도록 데이터 넣어놓기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_snackList"); //tiles 설정
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	
	/*======================
		    스낵 등록
	======================*/	
	
	//등록 폼
	@GetMapping("/snack/admin_insert.do")
	public String form() {
		return "admin_snackInsert"; //tiles 설정
	}

	//전송된 데이터 처리
	@PostMapping("/snack/admin_insert.do")
	public String submit(@Valid SnackVO snackVO,BindingResult result,
						 HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<상품 등록>> : " + snackVO);
		
		//유효성 체크 결과 오류 발생 시 폼을 다시 호출
		//if(result.hasErrors()) {
		//	return form();
		//}
		
		//등록 처리
		snackService.insertSnack(snackVO);
		
		model.addAttribute("message", "상품 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/snack/admin_list.do");
		
		return "common/resultView"; //jsp 호출
	}


	
	/*======================
		  상품 정보 수정	
	======================*/

	//수정 폼 호출
	@GetMapping("/snack/admin_update.do")
	public String formUpdate(@RequestParam int sn_num, Model model) {
		SnackVO snackVO = snackService.selectSnack(sn_num);
		
		//상품명,구성,내용에 태그를 허용하지 않음
		snackVO.setSn_name(StringUtil.useNoHtml(snackVO.getSn_name()));
		snackVO.setSn_detail(StringUtil.useNoHtml(snackVO.getSn_detail()));
		snackVO.setSn_info(StringUtil.useBrNoHtml(snackVO.getSn_info()));
		
		model.addAttribute("snackVO", snackVO);
		
		return "admin_snackUpdate";
	}
	
	//수정 폼 - 기존 사진 출력
	@RequestMapping("/snack/photoView.do")
	public String getPhoto(@RequestParam int sn_num,
									  HttpServletRequest request,
									  Model model) {
		log.debug("<<photoView>> : " + sn_num);
		SnackVO snackVO = snackService.selectSnack(sn_num);
		viewPhoto(snackVO, request, model); //만들어놓은 공통 코드에 넘겨주기만 하면 된다.
		
		return "imageView";
	}
	
	//사진 처리를 위한 공통 코드
	public void viewPhoto(SnackVO snackVO,HttpServletRequest request, Model model) {
		if(snackVO==null || snackVO.getSn_photo_name()==null) {
			//기본 이미지 읽기													//상대 경로를 넣으면 절대 경로를 구해줌
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/no_image.jpg"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "no_image.jpg");
		}else { //업로드한 사진이 있는 경우
			model.addAttribute("imageFile", snackVO.getSn_photo());
			model.addAttribute("filename", snackVO.getSn_photo_name());
		}
	}

	//전송된 데이터 수정 처리
	@PostMapping("/snack/admin_update.do")
	public String submitUpdate(@Valid SnackVO snackVO,
								BindingResult result,
								HttpServletRequest request,
								Model model) {
		log.debug("<<상품 수정 - SnackVO>> : " + snackVO);
		
		//유효성 체크 결과 오류가 있으면 폼을 다시 호출
		//if(result.hasErrors()) {
		//	return "admin_snackUpdate";
		//}
		
		//수정 처리
		snackService.updateSnack(snackVO);
		//View에 표시할 메시지
		model.addAttribute("message", "상품 수정이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/snack/admin_update.do?sn_num="+snackVO.getSn_num());
		
		return "common/resultView"; //jsp 호출
	}

	
	
	/*======================
		  상품 정보 삭제	
	======================*/	
	
	//수정 폼에서 단일 삭제
	@RequestMapping("/snack/admin_delete.do")
	public String submitDelete(@RequestParam int sn_num) {
		log.debug("<<상품 삭제 - sn_num>> : " + sn_num);
		
		//글 삭제
		snackService.deleteSnack(sn_num);
		
		return "redirect:/snack/admin_list.do";
	}
	
	//목록에서 체크박스 다중 삭제
	@RequestMapping("/snack/admin_deleteChBox.do")
	@ResponseBody
	public Map<String,String> submitDeleteChBox(@RequestParam String checkArr, HttpSession session) {
		Map<String,String> mapJson = new HashMap<String,String>();
		//로그인 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 X
			mapJson.put("result", "logout");
		}else { //로그인 O
			String[] checkArrs = checkArr.split(",");
			snackService.deleteChBox(checkArrs);
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
}
