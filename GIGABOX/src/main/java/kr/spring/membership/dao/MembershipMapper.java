package kr.spring.membership.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.membership.vo.MembershipVO;

@Mapper
public interface MembershipMapper {
	//멤버십 - 관리자
	//멤버십등록
	public void insertMembership(MembershipVO membershipVO);
	//멤버십갯수
	public int selectMembershipCount(Map<String, Object> map);
	//멤버십목록
	public List<MembershipVO> selectMembershipList(Map<String, Object> map);
	
	@Select("SELECT * FROM membership WHERE membership_id=#{membership_id}")
	public MembershipVO selectMembership(Integer membership_id);
	//멤버십수정
	public void updateMembership(MembershipVO membershipVO);
	//멤버십삭제
	@Delete("DELETE FROM membership WHERE membership_id=#{membership_id}")
	public void deleteMembership(Integer membership_id);
	
	//멤버십 - 유저
	//멤버십목록
	public List<MembershipVO> selectMembershipUserList(Map<String, Object> map);
	//멤버십선택
	MembershipVO getMembershipById(@Param("membershipId") int membershipId);
	
	
}
















