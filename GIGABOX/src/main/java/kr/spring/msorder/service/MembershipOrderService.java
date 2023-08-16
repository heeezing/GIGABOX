package kr.spring.msorder.service;


import kr.spring.msorder.vo.MembershipOrderVO;

public interface MembershipOrderService {
	//주문 등록
	public void insertOrder(MembershipOrderVO order);
}
