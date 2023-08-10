package kr.spring.order.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;

@Mapper
public interface OrderMapper {
	//[주문 등록]
	//주문번호 생성
	@Select("SELECT orders_seq.nextval FROM dual")
	public int selectOrderNum();
	//등록 - 주문에 대한 일반적인 사항
	public void insertOrder(OrderVO order);
	//등록 - 주문한 상품에 대한 사항
	public void insertOrderDetail(OrderDetailVO vo);
	//주문 완료된 상품을 장바구니에서 제거
	@Delete("DELETE FROM cart WHERE sn_num=#{sn_num} AND mem_num=#{mem_num}")
	public void deleteCartItem(@Param(value="sn_num") Integer sn_num,
						 	   @Param(value="mem_num") Integer mem_num);
	//[관리자] 전체or검색 레코드 수
	public int selectOrderCount(Map<String,Object> map);
	//[관리자] 전체or검색 목록
	public List<OrderVO> selectListOrder(Map<String,Object> map);
}
