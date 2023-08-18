package kr.spring.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;

@Mapper
public interface OrderMapper {
	//회원 번호를 이용한 멤버십 정보 구하기
	@Select("SELECT membership_grade FROM member LEFT OUTER JOIN membership_order USING(mem_num) WHERE mem_num=#{mem_num}")
	public String selectMembershipByMem_num(Integer mem_num);
	
	//주문 폼 - 선물 시 회원 조회
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) WHERE id=#{to_id} AND phone=#{to_phone}")
	public MemberVO searchMember(@Param(value="to_id") String to_id,
								 @Param(value="to_phone") String to_phone);
	//[주문 등록]
	//주문번호 생성
	@Select("SELECT 'S' || TO_CHAR(SYSDATE, 'YYMMDD') || LPAD(orders_seq.NEXTVAL, 6, '0') FROM dual")
	public String selectOrderNum();
	//구매 시 등록 - 주문에 대한 일반적인 사항
	public void insertOrder(OrderVO order);
	//선물 시 등록 - 주문에 대한 일반적인 사항
	public void insertGiftOrder(OrderVO order);
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

	//[사용자] 전체or검색 레코드 수
	public int selectOrderCountByMem_num(Map<String,Object> map);
	//[사용자] 전체or검색 목록
	public List<OrderVO> selectListOrderByMem_num(Map<String,Object> map);
	//주문 상세
	@Select("SELECT * FROM orders LEFT OUTER JOIN point USING(orders_num)"
		 + " WHERE orders_num=#{orders_num}")
	public OrderVO selectOrder(String orders_num);
	//개별 상품 목록
	@Select("SELECT * FROM orders_detail WHERE orders_num=#{orders_num} ORDER BY sn_num DESC")
	public List<OrderDetailVO> selectListOrderDetail(String orders_num);
	//사용 상태 변경 - 사용 완료, 주문 취소
	@Update("UPDATE orders SET orders_status=#{orders_status},modify_date=SYSDATE WHERE orders_num=#{orders_num}")
	public void statusChange(@Param(value="orders_num") String orders_num,
							 @Param(value="orders_status") Integer orders_status);
	//유효 기간 체크
//	@Select("SELECT * FROM orders WHERE valid_date < #{currentDate} AND orders_status = 1")
//	public List<OrderVO> statusNoValid(Date currentDate);
	
	//선물함 개수
	public int selectGiftCountByTo_id(Map<String,Object> map);
	//선물함 목록
	public List<OrderVO> selectListGiftByTo_id(Map<String,Object> map);
	
}
