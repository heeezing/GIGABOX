package kr.spring.member.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 일반회원
	//회원번호 생성
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	//회원가입
	@Insert("INSERT INTO member (mem_num,id,nick_name) VALUES (#{mem_num},#{id},#{nick_name})")
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	//ID를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String id);
	//회원번호를 이용한 회원정보 구하기
	@Select("SELECT * FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);
}  
