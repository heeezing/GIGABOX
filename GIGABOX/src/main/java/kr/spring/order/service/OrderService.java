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
	//기프티콘 번호 생성
	public String selectDetailNum();
	//주문 등록
	public void insertOrder(OrderVO order, List<OrderDetailVO> list);
	//주문 성공 UI에서 보여줄 주문번호
	public String getOrders_num(Integer mem_num);
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
	//[사용자-마이페이지] 최근 3개 구매 목록
	public List<OrderVO> selectListOrderByMem_num3(Integer mem_num);
	//주문 상세
	public OrderVO selectOrder(String orders_num);
	//개별 상품 목록
	public List<OrderDetailVO> selectListOrderDetail(String orders_num);
	//개별 상품 상세
	public OrderDetailVO selectDetail(String detail_num);
	//전체 사용 상태 변경 - 사용완료, 주문 취소
	public void statusAllChange(@Param(value="orders_num") String orders_num,
								@Param(value="orders_status") Integer orders_status);
	//개별 사용 상태 변경 
	public void statusChange(@Param(value="orders_num") String orders_num,
								@Param(value="orders_status") Integer orders_status);
	//사용 상태 변경 - 기간 만료
	public void statusChangeValid();
	//사용 가능한 선물이 하나라도 껴있는 주문의 개수 - 스토어 스낵 목록 메뉴의 선물함 카운트 용
	public int selectGiftCountPossible(String to_id);
	//선물함 개수 - 마이페이지 페이지 처리 용 (전체 주문 취소의 경우 카운트X)
	public int selectGiftCountByTo_id(Map<String,Object> map);
	//선물함 목록 - 마이페이지 (전체 주문 취소의 경우 표시X)
	public List<OrderVO> selectListGiftByTo_id(Map<String,Object> map);
}
