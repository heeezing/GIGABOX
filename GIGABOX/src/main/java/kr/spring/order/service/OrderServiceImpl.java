package kr.spring.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.MemberVO;
import kr.spring.order.dao.OrderMapper;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.point.dao.PointMapper;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private PointMapper pointMapper;
	
	@Override
	public void insertOrder(OrderVO order, List<OrderDetailVO> list) {
		//vo에는 order_num이 없기 때문에 따로 생성해서 넣어줌(호출할 때마다 1씩 증가하는 시퀀스)
		//order.setOrders_num(orderMapper.selectOrderNum());
		//주문 정보 등록
		orderMapper.insertOrder(order);
		//포인트 사용 및 적립 
		pointMapper.insertSnackPoint(order);
		//상품 정보 저장
		for(OrderDetailVO vo : list) {
			vo.setOrders_num(order.getOrders_num()); //생성해서 넣어놓은 걸 받아옴
			//주문 상품 정보 등록
			orderMapper.insertOrderDetail(vo);
			//주문 완료된 상품을 장바구니에서 제거
			orderMapper.deleteCartItem(vo.getSn_num(), order.getMem_num());
		}
	}

	@Override
	public void insertGiftOrder(OrderVO order, List<OrderDetailVO> list) {
		//주문 정보 등록
		orderMapper.insertGiftOrder(order);
		//포인트 사용 및 적립 
		pointMapper.insertSnackPoint(order);
		//상품 정보 저장
		for(OrderDetailVO vo : list) {
			vo.setOrders_num(order.getOrders_num()); //생성해서 넣어놓은 걸 받아옴
			//주문 상품 정보 등록
			orderMapper.insertOrderDetail(vo);
			//주문 완료된 상품을 장바구니에서 제거
			orderMapper.deleteCartItem(vo.getSn_num(), order.getMem_num());
		}
	}
	
	@Override
	public int selectOrderCount(Map<String, Object> map) {
		return orderMapper.selectOrderCount(map);
	}

	@Override
	public List<OrderVO> selectListOrder(Map<String, Object> map) {
		return orderMapper.selectListOrder(map);
	}

	@Override
	public String selectOrderNum() {
		return orderMapper.selectOrderNum();
	}

	@Override
	public MemberVO searchMember(String to_id, String to_phone) {
		return orderMapper.searchMember(to_id, to_phone);
	}

	@Override
	public int selectOrderCountByMem_num(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<OrderVO> selectListOrderByMem_num(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OrderVO selectOrder(String orders_num) {
		return orderMapper.selectOrder(orders_num);
	}

	@Override
	public List<OrderDetailVO> selectListOrderDetail(String orders_num) {
		return orderMapper.selectListOrderDetail(orders_num);
	}

	@Override
	public void updateStatusUse(String orders_num, Integer orders_status) {
		orderMapper.updateStatusUse(orders_num, orders_status);
	}

	@Override
	public String selectMembershipByMem_num(Integer mem_num) {
		return orderMapper.selectMembershipByMem_num(mem_num);
	}

}
