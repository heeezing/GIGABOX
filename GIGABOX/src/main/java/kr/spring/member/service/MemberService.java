package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService{
	//회원관리 - 일반회원
	//회원가입
	public void insertMember(MemberVO member);
	//ID를 이용한 회원정보 체크(ID중복체크)
	public MemberVO selectCheckMember(String id);
	//회원번호를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);

}
  