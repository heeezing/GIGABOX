package kr.spring.msorder.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.msorder.vo.MembershipOrderVO;

@Mapper
public interface MembershipOrderMapper {
	
	//주문번호 생성
	@Select("SELECT membership_order_seq.nextval FROM dual")
	public int selectOrderNum();
	//주문 등록
	public void insertOrder(MembershipOrderVO order);
}
