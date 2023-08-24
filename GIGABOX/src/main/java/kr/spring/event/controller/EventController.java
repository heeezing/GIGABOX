package kr.spring.event.controller;






import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventResultVO;
import kr.spring.cs.service.CsService;
import kr.spring.cs.vo.CategoryVO;
import kr.spring.cs.vo.CsVO;
import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EventController {
	
	@Autowired
	private EventService eventService;
	@Autowired
	private CsService csService;
	
	@ModelAttribute
	public EventVO initCommand() {
		return new EventVO();
	}
	//========================글 쓰기=================================
	//이벤트 작성 폼 불러오기 
	@GetMapping("/event/eventWrite.do")
	public String form() {
		return "eventWrite";
	}
	
	//이벤트 폼 업로드하기
	@PostMapping("/event/eventWrite.do")
	public String submitForm(EventVO eventVO,Model model,HttpServletRequest request,
							HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		eventVO.setMem_num(user.getMem_num());
		log.debug("<<eventVO>> : " + eventVO);
		eventService.insertEvent(eventVO);
		log.debug("<<작성 완료>>");
		
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 업로드되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/event/eventList.do");
		
		return "common/resultView";
	}
	
	@GetMapping("/event/eventModify.do")
	public ModelAndView eventModifyForm(@RequestParam int event_num) {
		ModelAndView mav = new ModelAndView();
		
		EventVO event = eventService.selectEvent(event_num);
		
		mav.setViewName("eventModify");
		mav.addObject("event", event);
		return mav;
	}
	
	@PostMapping("/event/eventModify.do")
	public String evnetModify(EventVO eventVO, 
			 Model model, HttpServletRequest request) {
		
		eventService.updateEvent(eventVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 수정되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/event/eventList.do");
		return "common/resultView";
	}
	
	@RequestMapping("/event/eventDelete.do")
	public String eventDelete(@RequestParam int event_num,
						 Model model, HttpServletRequest request) {
		
		eventService.deleteReplyByEventNum(event_num);
		eventService.deleteEvent(event_num);
		
		//View에 표시할 메시지
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/event/eventList.do");
		return "common/resultView";
	}
	
	//=========진행중 이벤트============
	@RequestMapping("/event/eventList.do")
	public ModelAndView list() {
		//가장 최근에 작성된 게시글 10개
		List<EventVO> list1 = new ArrayList<>();
		list1 = eventService.selectEventTop10List();
		
		//카테고리별 가장 최근에 작성된 4개의 게시글
		List<EventVO> list2 = new ArrayList<EventVO>();
		list2 = eventService.selectEventMainList();
		
		//카테고리
		List<CategoryVO> list3 = new ArrayList<CategoryVO>();
		list3 = eventService.selectDetailCategoryList();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventList");
		mav.addObject("list1", list1);
		mav.addObject("list2", list2);
		mav.addObject("list3", list3);
		return mav;
	}
	
	@RequestMapping("/event/eventActiList.do")
	public ModelAndView actiList(@RequestParam(value="detail",defaultValue = "1") int category_detail_num,
								 @RequestParam(value="pageNum",defaultValue = "1") int currentPage,
								 String keyfield, String keyword
								) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", 1); //제목에서만 검색
		map.put("keyword", keyword);
		map.put("category_num", 1);
		map.put("category_detail_num",category_detail_num);
		map.put("order", 2); //가장 최근에 시작한 이벤트 기준으로 정렬
		
		int count = eventService.selectRowCount(map);
		
		PagingUtil page = new PagingUtil(keyfield, keyword,currentPage, count, 20,10,"eventActiList.do");
				
		List<EventVO> list = new ArrayList<EventVO>();
		List<CategoryVO> list3 = new ArrayList<CategoryVO>();
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectEventList(map);
			
			//카테고리
			list3 = eventService.selectDetailCategoryList();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventActiList");
		mav.addObject("detail",category_detail_num );
		mav.addObject("count",count);
		mav.addObject("list", list);
		mav.addObject("list3", list3);
		return mav;
	}
	//=========지난 이벤트============
	@GetMapping("/event/eventEndList.do")
	public String endList() {
		return "eventEndList";
	}
	
	@PostMapping("/event/eventEndList.do")
	@ResponseBody
	public Map<String,Object> endList(
		@RequestParam(value="pageNum",
		           defaultValue="1") int currentPage,
		@RequestParam(value="rowCount",
		           defaultValue="10") int rowCount,
		                      HttpSession session
		                      ){
		log.debug("<<currentPage>> : " + currentPage);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("category_num", 2);
		map.put("order",1); //가장 최근 종료일 기준으로 정렬
		
		//전체 레코드수
		int count = eventService.selectRowCount(map);
	
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);
		
		List<EventVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectEventList(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapJson =
				new HashMap<String,Object>();
		mapJson.put("count",count);
		mapJson.put("list", list);
	
		return mapJson;
	}
	
	//=========당첨자 이벤트============
	@GetMapping("/event/eventResultList.do")
	public ModelAndView resultList(@RequestParam(value="pageNum", defaultValue = "1") int currentPage,
									String keyfield, String keyword) {
		List<EventVO> list = new ArrayList<EventVO>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyfield", 1);
		map.put("keyword", keyword);
		map.put("category_num",3);
		map.put("order",1);
		
		log.debug("<<map>> :" + map);
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> :" + count);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"eventResultList.do");
		if(count >0) {
			
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectEventList(map);
			log.debug("<<list>> :" + list);
		}
	
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventResultList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		return mav;
	}
	//=========페이지 보기============
	@RequestMapping("/event/detail.do")
	public ModelAndView detail(@RequestParam int event_num) {
		
		EventVO event = new EventVO();
		event = eventService.selectEvent(event_num);
		eventService.updateHit(event_num);
		
		List<TheaterVO> theater = new ArrayList<TheaterVO>();
		ModelAndView mav = new ModelAndView();
		
		if(event.getEvent_form_type() == 2) { //댓글 작성형 글이면 영화관 목록 던지기
			theater = csService.selectAllTheater();
			mav.addObject("theater", theater);
		}
		
		mav.setViewName("eventDetail");
		mav.addObject("event", event);
		return mav;
	}
	//=========이미지 보기============
	@RequestMapping("/event/imageView.do")
	public ModelAndView image(@RequestParam int thumb,
						@RequestParam int thumb_type) {
		
		
		EventVO eventVO = 
				eventService.selectEvent(thumb);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		if(thumb_type==1) {//thumb1
			mav.addObject("imageFile", eventVO.getThumb1());
			mav.addObject("filename", eventVO.getThumb1_name());
		}else if(thumb_type==2) {//photo2
			mav.addObject("imageFile", eventVO.getThumb2());
			mav.addObject("filename", eventVO.getThumb2_name());
		}
		
		return mav;
	}
	//=========댓글 처리============
	//댓글 등록
	@RequestMapping("/event/writeReply.do")
	@ResponseBody
	public Map<String,String> writeReply(EventReplyVO eventReplyVO,
			                    HttpSession session,
			                    HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + eventReplyVO);
		Map<String,String> mapJson = new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//중복 댓글이 있는지 확인하기. event_num과 mem_num을 이용함.
		//회원번호 등록
		EventReplyVO db_reply = new EventReplyVO();
		db_reply.setEvent_num(eventReplyVO.getEvent_num());
		db_reply.setMem_num(user.getMem_num());
		
		boolean check = eventService.checkReply(db_reply);
		//이게 왜 데드 코드야.. 
		if(user==null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		
		}else if(check == true){//이미 참여한 전적이 있는 경우
			mapJson.put("result", "duplicated");
		}else {
			eventReplyVO.setMem_num(user.getMem_num());
			//ip 등록
			eventReplyVO.setIp(request.getRemoteAddr());
			//댓글 등록
			eventService.insertReply(eventReplyVO);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	//댓글 목록
	@RequestMapping("/event/listReply.do")
	@ResponseBody
	public Map<String,Object> getList(
		@RequestParam(value="pageNum",
		           defaultValue="1") int currentPage,
		@RequestParam(value="rowCount",
		           defaultValue="10") int rowCount,
		@RequestParam int event_num,
		                      HttpSession session){
		log.debug("<<currentPage>> : " + currentPage);
		log.debug("<<event_num>> : " + event_num);
		
		Map<String,Object> map = 
				        new HashMap<String,Object>();
		map.put("event_num", event_num);
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		
		//전체 레코드수
		int count = eventService.selectRowCountReply(map);
		
		//페이지 처리
		PagingUtil page = 
			new PagingUtil(currentPage,
					count,rowCount,1,null);
		
		List<EventReplyVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectListReply(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapJson =
				new HashMap<String,Object>();
		mapJson.put("count",count);
		mapJson.put("list", list);
		//====로그인 한 회원정보 셋팅====
		if(user!=null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	//댓글 삭제
	@RequestMapping("/event/deleteReply.do")
	@ResponseBody
	public Map<String,String> deleteReply(
			   @RequestParam int reply_num,
			            HttpSession session){
		log.debug("<<reply_num>> : " + reply_num);
		
		Map<String,String> mapJson =
				new HashMap<String,String>();
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		EventReplyVO db_reply = 
				eventService.selectReply(reply_num);
		if(user==null) {
			//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null 
			&& user.getMem_num()==db_reply.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 일치
			eventService.deleteReply(reply_num);
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	//댓글 수정
	@RequestMapping("/event/updateReply.do")
	@ResponseBody
	public Map<String,String> modifyReply(
			EventReplyVO eventReplyVO,
			HttpSession session,
			HttpServletRequest request){
		log.debug("<<EventReplyVO>> : " + eventReplyVO);
		
		Map<String,String> mapJson = 
				      new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		EventReplyVO db_reply = eventService.selectReply(
				                 eventReplyVO.getReply_num());
		if(user==null) {//로그인이 되지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null 
			&& user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호가 일치
			//ip등록
			eventReplyVO.setIp(request.getRemoteAddr());
			log.debug("<<eventReplyVO 입력 >> : " + eventReplyVO);
			//댓글 수정
			eventService.updateReply(eventReplyVO);
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호가 불일치
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	@GetMapping("/event/eventResultWrite.do")
	public ModelAndView resultWriteForm(@RequestParam int event_num) {
		
		List<EventReplyVO> list = eventService.selectReplyList(event_num);
		EventVO event = eventService.selectEvent(event_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("event_num", event_num);
		mav.addObject("eventName", event.getTitle());
		mav.addObject("list", list);
		mav.setViewName("eventResultWrite");
		return mav;
	}
	
	@PostMapping("/event/eventResultWrite.do")
	public String resultWrite(EventResultVO eventResultVO, HttpSession session ,Model model, HttpServletRequest request) {
		MemberVO user = (MemberVO)session.getAttribute("user");
	
		eventResultVO.setMem_num(user.getMem_num());
		
		eventService.insertEventResult(eventResultVO);
		eventService.updateState1(eventResultVO.getEvent_num());
		
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 업로드되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/event/eventResultList.do");
		
		return "common/resultView";
	}
	
	@RequestMapping("/event/eventResultDetail.do")
	public ModelAndView resultDetail(@RequestParam int event_num) {
		EventResultVO vo = eventService.selectEventResult(event_num);
		ModelAndView mav = new ModelAndView();
		mav.addObject("event", vo);
		mav.setViewName("eventResultDetail");
		return mav;
	}
	@GetMapping("/event/eventResultUpdate.do")
	public ModelAndView resultupdateForm(@RequestParam int event_num) {
		
		EventResultVO event = eventService.selectEventResult(event_num);
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("event", event);
		mav.setViewName("eventResultUpdate");	
		return mav;
	}
	
	@PostMapping("/event/eventResultUpdate.do")
	public String resultupdateForm(EventResultVO eventResultVO,Model model, HttpServletRequest request) {
		eventService.updateEventResult(eventResultVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "수정되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/event/eventResultList.do");
			
		return "common/resultView";
	}
	@RequestMapping("/event/eventResultDelete.do")
	public String resultDelete(@RequestParam int event_num, Model model, HttpServletRequest request) {
		eventService.deleteEventResult(event_num);
		eventService.updateState0(event_num);
		//View에 표시할 메시지
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/event/eventResultList.do");
			
		return "common/resultView";
	}

	@PostMapping("/event/randomSelect.do")
	@ResponseBody
	public Map<String,Object> ranbomList(
		@RequestParam(value="event_num") int event_num,
		@RequestParam(value="method") int method,
		@RequestParam(value="selectNum") int selectNum){
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		log.debug("<<what....?>> : " + event_num + method + selectNum);
		
		map.put("event_num", event_num);
		map.put("selectNum", selectNum);
		List<Integer> numbers = null;
		if(method == 1){ // 무작위
			numbers = eventService.selectRandom(map);
		}else if(method == 2) { //선착순
			numbers = eventService.selectRandomReg_date(map);
		}
		log.debug("<<>> :" + numbers);
		Map<String,Object> mapJson =
				new HashMap<String,Object>();
		mapJson.put("list", numbers);
		return mapJson;
	}
	
	@RequestMapping("/event/eventAdminList.do")
	public ModelAndView AdminList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
								  String keyfield, String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyfield", keyfield); //제목에서만 검색
		map.put("keyword", keyword);

		int count = eventService.selectRowCount(map);
		
		PagingUtil page = new PagingUtil(keyfield, keyword,currentPage, count, 20,10,"eventAdminList.do");
				
		List<EventVO> list = new ArrayList<EventVO>();
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectEventList(map);
			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventAdminList");
		mav.addObject("count",count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		return mav;
	}
	

	
	@GetMapping("/event/eventResultAdminList.do")
	public ModelAndView resultAdminList(@RequestParam(value="pageNum", defaultValue = "1") int currentPage,
									String keyfield, String keyword) {
		List<EventVO> list = new ArrayList<EventVO>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("keyfield", 1);
		map.put("keyword", keyword);
		map.put("category_num",3);
		map.put("order",1);
		
		log.debug("<<map>> :" + map);
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> :" + count);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"eventResultAdminList.do");
		if(count >0) {
			
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = eventService.selectEventList(map);
			log.debug("<<list>> :" + list);
		}
	
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventResultAdminList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		return mav;
	}
}
