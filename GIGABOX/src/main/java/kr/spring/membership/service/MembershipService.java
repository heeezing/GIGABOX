package kr.spring.membership.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.membership.vo.MembershipVO;
import kr.spring.msorder.vo.MembershipOrderVO;

public interface MembershipService {
	//멤버십 - 관리자
		//멤버십등록
		public void insertMembership(MembershipVO membershipVO);
		//멤버십갯수
		public int selectMembershipCount(Map<String, Object> map);
		//멤버십목록
		public List<MembershipVO> selectMembershipList(Map<String, Object> map);
		
		public MembershipVO selectMembership(Integer membership_id);
		//멤버십수정
		public void updateMembership(MembershipVO membershipVO);
		//멤버십삭제
		public void deleteMembership(Integer membership_id);
		
	//멤버십 - 유저
		//멤버십목록
		public List<MembershipVO> selectMembershipUserList(Map<String, Object> map);
		//멤버십선택
		public MembershipVO getMembershipById(int membershipId);

}
