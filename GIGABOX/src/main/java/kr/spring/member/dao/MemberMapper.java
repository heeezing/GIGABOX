package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.snack.vo.SnackVO;

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
	
	//회원정보 수정
	@Update("UPDATE member SET nick_name=#{nick_name} WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	//비밀번호 수정
	@Update("UPDATE member_detail SET passwd=#{passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);
	//회원탈퇴
	@Update("UPDATE member SET auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);
	
	//프로필 이미지 업데이터
	@Update("UPDATE member_detail SET photo=#{photo}, photo_name=#{photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	
	//자동 로그인
	@Update("UPDATE member_detail SET au_id=#{au_id} WHERE mem_num=#{mem_num}")
	public void updateAu_id(@Param("au_id") String au_id, @Param("mem_num") int mem_num);
	@Select("SELECT m.mem_num,m.id,m.auth,d.au_id,d.passwd,m.nick_name,d.email FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE d.au_id=#{au_id}")
	public MemberVO selectAu_id(String au_id);
	@Update("UPDATE member_detail SET au_id='' WHERE mem_num=#{mem_num}")//이름은 delete로 했지만 레코드를 지우는게 아니기 때문에 update문 사용
	public void deleteAu_id(int mem_num);
	
	
}  
