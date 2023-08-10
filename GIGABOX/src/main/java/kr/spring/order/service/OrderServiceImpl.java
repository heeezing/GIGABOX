package kr.spring.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.order.dao.OrderMapper;
import kr.spring.order.vo.OrderDetailVO;
import kr.spring.order.vo.OrderVO;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public void insertOrder(OrderVO order, List<OrderDetailVO> list) {
		//vo에는 order_num이 없기 때문에 따로 생성해서 넣어줌(호출할 때마다 1씩 증가하는 시퀀스)
		order.setOrders_num(orderMapper.selectOrderNum());
		orderMapper.insertOrder(order);
		for(OrderDetailVO vo : list) {
			vo.setOrders_num(order.getOrders_num()); //생성해서 넣어놓은 걸 받아옴
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

}
