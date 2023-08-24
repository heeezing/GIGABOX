package kr.spring.cs.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import kr.spring.cs.service.CsService;
import kr.spring.cs.vo.CsVO;
import kr.spring.cs.vo.FileVO;

import kr.spring.mail.vo.MailVO;
import kr.spring.cs.vo.CategoryVO;
import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.FileUtil;
import kr.spring.util.FileUtils;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CsContorller {
	
	String uploadPath ="C:\\\\Users\\\\Hunter\\\\git\\\\GIGABOX\\\\GIGABOX\\\\src\\\\main\\\\webapp\\\\image_upload\\\\cs\\\\";
	
	@Autowired
	CsService csService;
	@Autowired
	MemberService MemberService;
	@Autowired
	FileUtils fileUtils;
	@Autowired
    JavaMailSender javaMailSender;
	@Autowired
	MemberService memberService;
	
	/*========================
	 * 자바빈(VO) 초기화
	 *========================*/
	@ModelAttribute
	public CsVO initCommand() {
		return new CsVO();
	}
	
	@GetMapping("/cs/csWrite.do")
	public ModelAndView form() {
		
		List<CategoryVO> category = new ArrayList<>();
		category = csService.selectAllQnaCategory();
		
		List<TheaterVO> theater = new ArrayList<>();
		theater = csService.selectAllTheater();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csWrite");
		mav.addObject("category", category);
		mav.addObject("theater", theater);
		return mav;
	}
	@PostMapping("/cs/csWrite.do")
	public String submit(@Valid CsVO csVO,
						@RequestParam(value="table",
							      defaultValue="0") int table,
						HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		csVO.setMem_num(user.getMem_num());
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("csVO", csVO);
		map.put("table", table);
		
		log.debug("<<csVO>> : "+ csVO);
		log.debug("<<table>> : "+ table);
		
		csService.insertCs(map);
		
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 업로드되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/cs/csMain.do");
		
		return "common/resultView";
	}
	
	
	
	@RequestMapping("/cs/csDetail.do")
	public ModelAndView csDetail(@RequestParam int detail_num, @RequestParam int table) {
		
		CsVO csVO = new CsVO();
		if(table == 1) {
			csVO = csService.selectQna(detail_num);
		}else if(table == 2) {
			csVO = csService.selectNoti(detail_num);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csDetail");
		mav.addObject("cs", csVO);
		
		return mav;
	}
	
	@GetMapping("/cs/csModify.do")
	public ModelAndView csModifyForm(@RequestParam int modify_num, 
			 						 @RequestParam int table ) {
		ModelAndView mav = new ModelAndView();
		
		CsVO csVO = new CsVO();
		
		List<CategoryVO> category = new ArrayList<>();
		category = csService.selectAllQnaCategory();
		
		List<TheaterVO> theater = new ArrayList<>();
		theater = csService.selectAllTheater();
		
		if(table == 1) {
			csVO = csService.selectQna(modify_num);
		}else if(table == 2) {
			csVO = csService.selectNoti(modify_num);
		}
		
		mav.setViewName("csModify");
		mav.addObject("cs", csVO);
		mav.addObject("table", table);
		mav.addObject("category", category);
		mav.addObject("theater", theater);
		
		return mav;
	}
	
	@PostMapping("/cs/csModify.do")
	public String csModify(CsVO csVO,
			 @RequestParam int table, 
			 Model model, HttpServletRequest request) {
		
		if(table == 1) {
			csService.updateQna(csVO);
		}else if(table == 2) {
			csService.updateNoti(csVO);
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 수정되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/cs/csMain.do");
		return "common/resultView";
	}
	
	@RequestMapping("/cs/csDelete.do")
	public String csDelete(@RequestParam int delete_num, 
						 @RequestParam int table, 
						 Model model, HttpServletRequest request) {
		
		if(table == 1) {
			csService.deleteQna(delete_num);
		}else if(table == 2) {
			csService.deleteNoti(delete_num);
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("url", 
		request.getContextPath()+"/cs/csMain.do");
		return "common/resultView";
	}
	

	@RequestMapping("/cs/csMain.do")
	public ModelAndView main() {
		
		Map<String,Object> map1 = new HashMap<String, Object>();
		Map<String,Object> map2 = new HashMap<String, Object>();
		
		//자주 묻는 질문 best 5개
		List<CsVO> list1 = null;
		map1.put("start", 1);
		map1.put("end", 5);
		list1 = csService.selectQnaList(map1);
		
		//공지사항 latest 5개		
		List<CsVO> list2 = null;
		map2.put("start", 1);
		map2.put("end", 5);
		list2 = csService.selectNotiList(map2);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csMain");
		mav.addObject("qna",list1);
		mav.addObject("noti",list2);

		return mav;
	}

	@RequestMapping("/cs/csQnaList.do")
	public ModelAndView qnaList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
								@RequestParam(value="category_num",defaultValue = "0") int category_num,
								String keyword, String keyfield
								) {
		Map<String,Object> map = new HashMap<String, Object>();
		
		map.put("table", 1); //cs_qna
		map.put("keyword", keyword);
		map.put("keyfield",1);
		
		//레코드 수 
		int count = csService.selectRowCount(map);
		
		//페이지 처리 
		PagingUtil page = new PagingUtil(keyfield, keyword, 
				currentPage, count, 20,10,"csQnaList.do");
		List<CsVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = csService.selectQnaList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csQnaList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		
		mav.addObject("page",page.getPage());
		
		return mav;
	}
	
	@RequestMapping("/cs/csNotiList.do")
	public ModelAndView notiList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
								String keyword, String keyfield) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		map.put("table", 2); //cs_noti
		map.put("keyword", keyword);
		map.put("keyfield",1);
		
		//레코드 수 
		int count = csService.selectRowCount(map);
		//페이지 처리 
		PagingUtil page = new PagingUtil(keyfield, keyword, 
				currentPage, count, 20,10,"csNotiList.do");
		List<CsVO> list = null;
		List<TheaterVO> theater = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = csService.selectNotiList(map);
		}
		theater = csService.selectAllTheater();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csNotiList");
		mav.addObject("count",count);
		mav.addObject("theater", theater);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
			
		return mav;
	}	
	
	@GetMapping("/cs/csPersonalWrite.do")
	public ModelAndView personalForm(HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_user = MemberService.selectMember(user.getMem_num());
		
		List<TheaterVO> theater = null;
		theater = csService.selectAllTheater();
		
		List<CategoryVO> category = null;
		category = csService.selectAllPersonalCategory();
		
		log.debug("<<theater>> : " + theater);
		log.debug("<<category>> : " + category);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csPersonalWrite");
		mav.addObject("category", category);
		mav.addObject("theater", theater);
		mav.addObject("user", db_user);
		return mav;
	}
	
	@PostMapping("/cs/csPersonalWrite.do")
	public String saveForm(CsPersonalVO csPersonalVO,
							HttpSession session, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<user>> : " + user);
	
		csPersonalVO.setMem_num(user.getMem_num());
		log.debug("<<csPersonalVO>> : " + csPersonalVO);
	
		csService.insertPersonal(csPersonalVO); //게시글 저장
		//View에 표시할 메시지
		model.addAttribute("message", "정상적으로 업로드되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/cs/csMain.do");
		
		return "common/resultView";
	}
	
	@RequestMapping("/cs/csPersonalList.do")
	public ModelAndView personalList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
			String keyword, String keyfield) {

		Map<String,Object> map = new HashMap<String, Object>();

		map.put("table", 3); //cs_personal
		map.put("keyword", keyword);
		map.put("keyfield",keyfield);

		//레코드 수 
		int count = csService.selectRowCount(map);
		//페이지 처리 
		PagingUtil page = new PagingUtil(keyfield, keyword, 
				currentPage, count, 20,10,"csPeronalList.do");
		List<CsPersonalVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = csService.selectPersonalList(map);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("csPersonalList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());

		return mav;
	}	
	
	@GetMapping("/cs/csPersonalAdminWrite.do")
	public ModelAndView getDetail(@RequestParam int personal_num) {
		log.debug("<<글 상세>> : "+personal_num);

		//글 상세 호출 
		CsPersonalVO cs= csService.selectCsPersonal(personal_num);
		
		//제목에 태그를 허용하지 않는다. 
		cs.setTitle(StringUtil.useNoHtml(cs.getTitle()));
		
		ModelAndView mav = new ModelAndView();
		
		List<FileVO> files = null;
		files = csService.SelectNameList(personal_num);
		if(!files.isEmpty()) {
			mav.addObject("files", files);
		}
		mav.setViewName("csPersonalAdminWrite");
		mav.addObject("cs",cs);
		
		return mav;
	}
	
	@PostMapping("/cs/csPersonalAdminWrite.do")
	public String saveAdminForm(CsPersonalVO csPersonalVO ,HttpSession session ,Model model, HttpServletRequest request) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<user>> : " + user);
		
		csPersonalVO.setMem_num(user.getMem_num());
		log.debug("<<csPersonalVO>> : " + csPersonalVO);
		
		csService.insertAdminPersonal(csPersonalVO);
		csService.updateState1(csPersonalVO.getPersonal_num());
		
		//질문글 검색 => 작성자 mem_num
		CsPersonalVO cs = csService.selectCsPersonal(csPersonalVO.getPersonal_num());
		
		MemberVO member = memberService.selectMember(cs.getMem_num());
		log.debug("<<email주소>> : "+ member.getEmail());
		
		//이메일 쓰기
		MailVO mail = new MailVO();
		mail.setEmail(member.getEmail());
		mail.setTitle( csPersonalVO.getTitle());
		mail.setContent(csPersonalVO.getContent());
		
		log.debug("<<mail>> : " + mail);
		
		//안내 이메일 보내기 
		ResponseEntity<Object> output = send(mail);
		log.debug("<<output>> : " + output);
		
		//View에 표시할 메시지
		if(output != null) {
			model.addAttribute("message", "답변 이메일이 전송되었습니다.");
		}else {
			model.addAttribute("message", "답변 이메일 전송중 문제가 발생하였습니다.");
		}
	
		model.addAttribute("url",request.getContextPath()+"/cs/csPersonalList.do");
		return "common/resultView";
	}
	
	@GetMapping("/cs/csPersonalDetail.do")
	public ModelAndView getDetail2(@RequestParam int personal_num) {
		log.debug("<<글 상세>> : "+personal_num);

		//글 상세 호출 
		CsPersonalVO cs= csService.selectCsPersonal(personal_num);
		//제목에 태그를 허용하지 않는다. 
		cs.setTitle(StringUtil.useNoHtml(cs.getTitle()));
		
		ModelAndView mav = new ModelAndView();
		if(cs.getState() != 0 ) {
			CsPersonalVO answer = csService.selectCsAnswer(cs.getPersonal_num());
			mav.addObject("answer", answer);
		}
		List<FileVO> files = null;
		files = csService.SelectNameList(personal_num);
		if(!files.isEmpty()) {
			mav.addObject("files", files);
		}
		mav.addObject("cs", cs);
		mav.setViewName("csPersonalDetail");
		return mav;
	}
	
	@RequestMapping("/cs/csPersonalDelete.do")
	public String personalDelete(@RequestParam int personal_num, Model model, HttpServletRequest request, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		CsPersonalVO vo = csService.selectCsPersonal(personal_num);
		//파일 삭제하기 
		if(user.getMem_num() == vo.getMem_num()) {
			
			if(vo.getState() == 1) {
				csService.deleteCsAnswer(personal_num);
			}
			csService.deleteCsFile(personal_num);//첨부파일 삭제
			csService.deleteCsPersonal(personal_num);
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/cs/csPersonalList.do");
		return "common/resultView";
	}
	
	@RequestMapping("/cs/csPersonalAdminDelete.do")
	public String personalAdminDelete(@RequestParam int personal_num, Model model, HttpServletRequest request, HttpSession session) {
		
		csService.deleteCsAnswer(personal_num);
		csService.updateState0(personal_num);

		//View에 표시할 메시지
		model.addAttribute("message", "삭제되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/cs/csPersonalList.do");
		return "common/resultView";
	}
	
	@GetMapping("/cs/csPersonalAdminUpdate.do")
	public ModelAndView updateForm(@RequestParam int personal_num) {
		
		log.debug("<<글 상세>> : "+personal_num);

		//글 상세 호출 
		CsPersonalVO cs= csService.selectCsPersonal(personal_num);
		//제목에 태그를 허용하지 않는다. 
		cs.setTitle(StringUtil.useNoHtml(cs.getTitle()));
		
		ModelAndView mav = new ModelAndView();
		if(cs.getState() != 0 ) {
			CsPersonalVO answer = csService.selectCsAnswer(cs.getPersonal_num());
			mav.addObject("answer", answer);
		}
		
		List<FileVO> files = null;
		files = csService.SelectNameList(personal_num);
		if(!files.isEmpty()) {
			mav.addObject("files", files);
		}
		
		mav.addObject("cs", cs);
		mav.setViewName("csPersonalAdminUpdate");
		return mav;
	}
	
	@PostMapping("/cs/csPersonalAdminUpdate.do")
	public String update(CsPersonalVO csPersonalVO,Model model,HttpServletRequest request) {
		csService.updateCsAnswer(csPersonalVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "수정되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/cs/csPersonalList.do");
		
		return"common/resultView";
	}
	
	//파일 다운로드 
	@RequestMapping("/filedownload")
	public void downloadFile(@RequestParam int file_num, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        	FileVO file = csService.selectFile(file_num);
 
            String saveFileName = file.getSave_name(); 
            String originalFileName = file.getOrigin_name();

            
            byte fileByte[] = FileUtil.getBytes(uploadPath + saveFileName);
            
            response.setContentType("application/octet-stream");
            response.setContentLength(fileByte.length);
            
            response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8") +"\";");
            response.setHeader("Content-Transfer-Encoding", "binary");
            
            response.getOutputStream().write(fileByte);
            response.getOutputStream().flush();
            response.getOutputStream().close();
	}
	
		public ResponseEntity<Object> send(MailVO mailVO) {
	
	        // 이메일 발신될 데이터 적재
	        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
	        simpleMailMessage.setTo(mailVO.getEmail());//받는사람 주소
	        simpleMailMessage.setSubject(mailVO.getTitle());
	        simpleMailMessage.setText(mailVO.getContent());
	
	        // 이메일 발신
	        javaMailSender.send(simpleMailMessage);
	
	        // 결과 반환
	        return ResponseEntity.ok(true);
	    }
		
		@RequestMapping("/cs/csNotiAdminList.do")
		public ModelAndView notiAdminList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
									String keyword, String keyfield) {
			
			Map<String,Object> map = new HashMap<String, Object>();
			
			map.put("table", 2); //cs_noti
			map.put("keyword", keyword);
			map.put("keyfield",1);
			
			//레코드 수 
			int count = csService.selectRowCount(map);
			//페이지 처리 
			PagingUtil page = new PagingUtil(keyfield, keyword, 
					currentPage, count, 20,10,"csNotiAdminList.do");
			List<CsVO> list = null;
	
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = csService.selectNotiList(map);
			}
	
			ModelAndView mav = new ModelAndView();
			mav.setViewName("csNotiAdminList");
			mav.addObject("count",count);
			mav.addObject("list",list);
			mav.addObject("page",page.getPage());
				
			return mav;
		}	
		
		@RequestMapping("/cs/csQnaAdminList.do")
		public ModelAndView qnaAdminList(@RequestParam(value="pageNum",defaultValue = "1") int currentPage,
									String keyword, String keyfield) {
			
			Map<String,Object> map = new HashMap<String, Object>();
			
			map.put("table", 1); 
			map.put("keyword", keyword);
			map.put("keyfield",1);
			
			//레코드 수 
			int count = csService.selectRowCount(map);
			//페이지 처리 
			PagingUtil page = new PagingUtil(keyfield, keyword, 
					currentPage, count, 20,10,"csQnaAdminList.do");
			List<CsVO> list = null;
	
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = csService.selectQnaList(map);
			}
	
			ModelAndView mav = new ModelAndView();
			mav.setViewName("csQnaAdminList");
			mav.addObject("count",count);
			mav.addObject("list",list);
			mav.addObject("page",page.getPage());
				
			return mav;
		}	
}
