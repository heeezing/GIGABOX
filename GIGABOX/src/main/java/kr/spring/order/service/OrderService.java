package kr.spring.order.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;

public interface OrderService {
	//회원 번호를 이용한 멤버십 정보 구하기
	public String selectMembershipByMem_num(Integer mem_num);
	//주문 폼 - 선물 시 회원 조회
	public MemberVO searchMember(@Param(value="to_id") String to_id,
								 @Param(value="to_phone") String to_phone);
	//주문 번호 생성
	public String selectOrderNum();
	//주문 등록
	public void insertOrder(OrderVO order, List<OrderDetailVO> list);
	//선물 등록 
	public void insertGiftOrder(OrderVO order, List<OrderDetailVO> list);
	//[관리자] 전체or검색 레코드 수
	public int selectOrderCount(Map<String,Object> map);
	//[관리자] 전체or검색 목록
	public List<OrderVO> selectListOrder(Map<String,Object> map);
	//[사용자] 전체or검색 레코드 수
	public int selectOrderCountByMem_num(Map<String,Object> map);
	//[사용자] 전체or검색 목록
	public List<OrderVO> selectListOrderByMem_num(Map<String,Object> map);
	//주문 상세
	public OrderVO selectOrder(String orders_num);
	//개별 상품 목록
	public List<OrderDetailVO> selectListOrderDetail(String orders_num);
	//사용 상태 변경 - 사용 완료
	public void updateStatusUse(@Param(value="orders_num") String orders_num,
								@Param(value="orders_status") Integer orders_status);
}
