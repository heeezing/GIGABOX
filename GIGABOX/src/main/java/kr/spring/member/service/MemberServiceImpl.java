package kr.spring.member.service;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Session;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberMapper memberMapper;
	
	//회원관리 - 일반회원
	//회원가입
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
	}

	@Override
	public MemberVO selectCheckMember(String id) {
		return memberMapper.selectCheckMember(id);
	}

	@Override
	public MemberVO selectMember(Integer mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	@Override
	public void updateMember(MemberVO member) {
		memberMapper.updateMember(member);
		memberMapper.updateMember_detail(member);	
	}

	@Override
	public void updatePassword(MemberVO member) {
		memberMapper.updatePassword(member);
	}
	
	@Override
	public void deleteMember(Integer mem_num) {
		memberMapper.deleteMember(mem_num);
		memberMapper.deleteMember_detail(mem_num);
	}

	
	@Override
	public void updateAu_id(String au_id, int mem_num) {
		memberMapper.updateAu_id(au_id, mem_num);
	}

	@Override
	public MemberVO selectAu_id(String au_id) {
		return memberMapper.selectAu_id(au_id);
	}

	@Override
	public void deleteAu_id(int mem_num) {
		memberMapper.deleteAu_id(mem_num);
	}

	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
		
	}

	//비밀번호 찾기 이메일발송
	@Override
	public void sendEmail(MemberVO vo, String div) throws Exception {
	    String charSet = "utf-8";
	    String hostSMTP = "smtp.naver.com";
	    String hostSMTPid = "wjdqudgml03@naver.com"; // 전체 이메일 주소
	    String hostSMTPpwd = "wjdqudgml11!~~";
	    String fromEmail = "wjdqudgml03@naver.com";
	    String fromName = "gigabox";
	    String subject = "";
	    String msg = "";
	    
	    if(div.equals("findpw")) {
	        subject = "임시 비밀번호 입니다.";
	        msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
	        msg += "<h3 style='color: blue;'>";
	        msg += vo.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
	        msg += "<p>임시 비밀번호 : ";
	        msg += vo.getPasswd() + "</p></div>";
	    }
	    
	    String mail = vo.getEmail();
	    HtmlEmail email = new HtmlEmail();
	    email.setDebug(true);
	    email.setCharset(charSet);
	    email.setHostName(hostSMTP);
	    
	    // 인증 설정
	    email.setAuthentication(hostSMTPid, hostSMTPpwd);
	    
	    // 프로퍼티 설정
	    Properties properties = new Properties();
	    properties.setProperty("mail.smtp.starttls.enable", "true");
	    properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
	    properties.setProperty("mail.smtp.ssl.ciphers", "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256");
	    
	    // 포트 설정
	    properties.setProperty("mail.smtp.port", "587");
	    email.setAuthentication(hostSMTPid, hostSMTPpwd);
	    email.setMailSession(Session.getDefaultInstance(properties));
	    
	    email.setFrom(fromEmail, fromName, charSet);
	    email.addTo(mail, charSet);
	    email.setSubject(subject);
	    email.setHtmlMsg(msg);

	    email.send();
	}

	//비밀번호찾기
	@Override
	public void findPw(HttpServletResponse response, MemberVO vo) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		MemberVO ck = memberMapper.readMember(vo.getId());
		PrintWriter out = response.getWriter();
		// 가입된 아이디가 없으면

		// 가입된 이메일이 아니면
		if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo.setPasswd(pw);
			// 비밀번호 변경
			memberMapper.updatePassword(vo);
			// 비밀번호 변경 메일 발송
			sendEmail(vo, "findpw");

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}

	@Override
	public int updatePw(MemberVO vo) throws Exception {
		return memberMapper.updatePw(vo);
	}

	@Override
	public String find_id(String name, String phone) {
		String result = "";
		
		try {
		 result= memberMapper.find_id(name, phone);
		 
		} catch(Exception e) {
			
			e.printStackTrace();
		}
		
		return result ;
	}








}  
