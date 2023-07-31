package kr.spring.membership.service;

import kr.spring.membership.vo.MembershipVO;

public interface MembershipService {
	//멤버십 관리 - 관리자
		//멤버십등록
		public void insertMembership(MembershipVO membership);
}
