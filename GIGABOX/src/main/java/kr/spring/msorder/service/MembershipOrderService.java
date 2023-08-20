package kr.spring.msorder.service;


import kr.spring.msorder.vo.MembershipOrderVO;

public interface MembershipOrderService {
	//주문번호 생성
	public int selectOrderNum();
	//주문 등록
	public void insertOrder(MembershipOrderVO order);
}
