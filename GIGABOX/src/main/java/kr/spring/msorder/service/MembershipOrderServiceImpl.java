package kr.spring.msorder.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.msorder.dao.MembershipOrderMapper;
import kr.spring.msorder.vo.MembershipOrderVO;

@Service
@Transactional
public class MembershipOrderServiceImpl implements MembershipOrderService {
	@Autowired
	private MembershipOrderMapper orderMapper;
	
	@Override
	public void insertOrder(MembershipOrderVO order) {
		orderMapper.insertOrder(order);
		order.setOrder_num(orderMapper.selectOrderNum());
	}

	@Override
	public int selectOrderNum() {
		return orderMapper.selectOrderNum();
	}

}
