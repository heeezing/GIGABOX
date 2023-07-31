package kr.spring.membership.service;

import java.util.List;
import java.util.Map;

import kr.spring.membership.vo.MembershipVO;

public interface MembershipService {
	//멤버십 관리 - 관리자
		//멤버십등록
		public void insertMembership(MembershipVO membership);
		
		//멤버십 목록
		public int selectRowCount(Map<String,Object> map);
		public List<MembershipVO> selectList(Map<String,Object> map);
}
