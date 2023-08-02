package kr.spring.membership.service;

import java.util.List;
import java.util.Map;

import kr.spring.membership.vo.MembershipVO;

public interface MembershipService {
	//멤버십 관리 - 관리자
		//멤버십등록
		public void insertMembership(MembershipVO membership);
		//멤버십 번호를 이용한 멤버십 정보 구하기
		public MembershipVO selectMembership(Integer membership_id);
		
		//멤버십 수정
		public void updateMembership(MembershipVO membership);
		//멤버십 삭제
		public void deleteMembership(Integer membership_id);
		
		//멤버십 목록
		public int selectRowCount(Map<String,Object> map);
		public List<MembershipVO> selectList(Map<String,Object> map);
}
