package kr.spring.membership.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.membership.vo.MembershipVO;

@Mapper
public interface MembershipMapper {
	//멤버십 관리 - 관리자
	//멤버십 번호 생성
	@Select("SELECT membership_seq.nexval FROM dual")
	public int selectMembership_id();
	//멤버십 번호를 이용한 멤버십 정보 구하기
	@Select("SELECT * FROM membership WHERE membership_id=#{membership_id}")
	public MembershipVO selectMembership(Integer membership_id);
	//멤버십등록
	@Insert("INSERT INTO membership (membership_id,membership_grade,membership_detail,price) VALUES (#{membership_id},#{membership_grade},#{membership_detail},#{price})")
	public void insertMembership(MembershipVO membership);
	//멤버십 리스트
	public int selectRowCount(Map<String,Object> map);
	public List<MembershipVO> selectList(Map<String,Object> map);
	//멤버십 수정
	@Update("UPDATE membership SET membership_grade=#{membership_grade},"
			+ "membership_detail=#{membership_detail},"
			+ "price=#{price} "
			+ "WHERE membership_id=#{membership_id}")
	public void updateMembership(MembershipVO membership);
	//멤버십 삭제
	@Delete("DELETE FROM membership WHERE membership_id=#{membership_id}")
	public void deleteMembership(Integer membership_id);
	
}
