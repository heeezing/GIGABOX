package kr.spring.membership.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.membership.vo.MembershipVO;

@Mapper
public interface MembershipMapper {
	//멤버십 관리 - 관리자
	public MembershipVO selectMembership(Integer membership_id);
	//멤버십등록
	public void insertMembership(MembershipVO membership);
	//멤버십 리스트
	public int selectRowCount(Map<String,Object> map);
	public List<MembershipVO> selectList(Map<String,Object> map);
	//멤버십 수정/삭제
	@Update("UPDATE membership SET membership_grade=#{membership_grade},"
			+ "membership_detail=#{membership_detail},"
			+ "price=#{price} "
			+ "WHERE membership_id=#{membership_id}")
	public void updateMembership(MembershipVO membership);
	@Delete("DELETE FROM membership WHERE membership_id=#{membership_id}")
	public void deleteMembership(Integer membership_id);
	
}
