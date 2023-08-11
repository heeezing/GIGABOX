package kr.spring.theater.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.service.TheaterService;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TheaterController {
	@Autowired
	private TheaterService theaterService;
	
	/*===============
	 * 극장 등록
	 *===============*/
	// 극장 등록 폼 호출
	@GetMapping("/theater/theaterAdd.do")
	public String form() {
		return "theaterAdd";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/theater/theaterAdd.do")
	public String submit(TheaterVO theaterVO,BindingResult result,HttpServletRequest request,HttpSession session, Model model) {
		log.debug("<<극장 등록>> : " + theaterVO);
		
		theaterService.insertTheater(theaterVO);
		
		model.addAttribute("message", "극장 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/theater/theaterList.do");
		
		return "common/resultView";
	}
	
	
	// 사진 출력(극장번호 지정)
	@RequestMapping("/theater/photoViewByTh_num.do")
	public String getProfileByTh_num(@RequestParam int th_num,HttpServletRequest request,Model model) {
		TheaterVO theaterVO = theaterService.selectTheater(th_num);
		viewPhoto(theaterVO,request,model);
		
		return "imageView";
	}
	
	// 사진 미리보기
	@RequestMapping("/theater/photoView.do")
	public String viewPhoto(TheaterVO theaterVO,HttpServletRequest request, Model model) {

		if(theaterVO==null || theaterVO.getTh_photoname()==null) {
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/preview.png"));
			model.addAttribute("imageFile",readbyte);
			model.addAttribute("filename","preview.png");

		}else { // 업로드한 사진이 있는 경우
			model.addAttribute("imageFile", theaterVO.getTh_photo());
			model.addAttribute("filename", theaterVO.getTh_photoname());
		}
		return "imageView";
	}
	
	/*===============
	 * 극장 목록
	 *===============*/
	@RequestMapping("/theater/theaterList.do")
	public ModelAndView getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, String keyfield, String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = theaterService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "theaterList.do");
		
		List<TheaterVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = theaterService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("theaterList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*===============
	 * 극장 수정
	 *===============*/
	// 수정 폼 호출
	@GetMapping("/theater/theaterUpdate.do")
	public String formUpdate(@RequestParam int th_num,Model model) {
		TheaterVO theaterVO = theaterService.selectTheater(th_num);
		model.addAttribute("theaterVO",theaterVO);
		
		return "theaterModify";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/theater/theaterUpdate.do")
	public String submitUpdate(TheaterVO theaterVO,BindingResult result,HttpServletRequest request,Model model) {
		log.debug("<<극장 수정 - TheaterVO>> : " + theaterVO);
		
		// 극장 수정
		theaterService.updateTheater(theaterVO);
		
		// View에 표시할 메시지
		model.addAttribute("message", "극장 수정 완료");
		model.addAttribute("url", request.getContextPath()+"/theater/theaterList.do");
		
		return "common/resultView";
	}
	
	/*===============
	 * 극장 삭제
	 *===============*/
	@RequestMapping("/theater/theaterDelete.do")
	public String submitDelete(@RequestParam int th_num) {
		log.debug("<<상영관 삭제 - th_num>> : " + th_num);
		
		// 글삭제
		theaterService.deleteTheater(th_num);
		
		return "redirect:/theater/theaterList.do";
	}
	
	/*===============
	 * 극장 정보
	 *===============*/
	@RequestMapping("/theater/theaterDetail.do") // url
	public ModelAndView getChoiceList() {
		List<TheaterVO> list = theaterService.selectTheaterList();
		List<Date> dateList = getDate();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("theaterDetail"); // jsp 명
		mav.addObject("list", list);
		
		mav.addObject("dateList", dateList);
		
		return mav;
	}
	
	@RequestMapping("/theater/selectTheater.do")
	@ResponseBody
	public TheaterVO selectTheater(@RequestParam int th_num) {
		TheaterVO theater = theaterService.selectTheater(th_num);
		return theater;
	}
	
	/*===============
	 * 날짜 선택
	 *===============*/
	public List<Date> getDate(){
		
		Date now = new Date();
        List<Date> dateList = new ArrayList<>();

        // Calendar 객체를 사용하여 오늘 날짜를 설정
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 오늘 날짜부터 14일 후까지의 날짜를 리스트에 추가
        for (int i=0; i<14; i++) {
        	dateList.add(calendar.getTime());
            calendar.add(Calendar.DAY_OF_MONTH, 1); // 하루를 더함
        }
        
		return dateList;
	}
	
	/*===============
	 * 상영시간표
	 *===============*/
	@RequestMapping("/theater/getScheduleList.do")
	@ResponseBody
	public Map<String,Object> getScheduleList(@RequestParam int th_num,@RequestParam String sch_date){
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("th_num", th_num);
		map.put("sch_date", sch_date);
		
		List<ScheduleVO> scheduleList = theaterService.selectScheduleList(map);
		
		mapJson.put("scheduleList", scheduleList);
		
		return mapJson;
	}
	
}
