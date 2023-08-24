package kr.spring.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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
		return orderMapper.selectOrderCountByMem_num(map);
	}

	@Override
	public List<OrderVO> selectListOrderByMem_num(Map<String, Object> map) {
		return orderMapper.selectListOrderByMem_num(map);
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
	public void statusChange(String orders_num, Integer orders_status) {
		/*
		OrderVO order = orderMapper.selectOrder(orders_num);
		if(orders_status == 4) {
			int db_use_point = order.getUse_point();
			
			if(db_use_point != null) {
				PointVO pointVO = new PointVO();
				pointMapper.insertRefundPoint(null);
			}
		}
		*/
		orderMapper.statusChange(orders_num, orders_status);
		
	}

	@Override
	public String selectMembershipByMem_num(Integer mem_num) {
		return orderMapper.selectMembershipByMem_num(mem_num);
	}

	@Override
	public int selectGiftCountByTo_id(Map<String, Object> map) {
		return orderMapper.selectGiftCountByTo_id(map);
	}

	@Override
	public List<OrderVO> selectListGiftByTo_id(Map<String, Object> map) {
		return orderMapper.selectListGiftByTo_id(map);
	}

	@Override
	public List<OrderVO> selectListOrderByMem_num3(Integer mem_num) {
		return orderMapper.selectListOrderByMem_num3(mem_num);
	}

   @Override
    public void statusChangeValid() {
        orderMapper.statusChangeValid();
    }

    @Scheduled(cron = "0 0 0 * * ?") // 매일 자정에 실행
    public void performScheduledTask() {
        statusChangeValid(); 
    }

	@Override
	public String selectDetailNum() {
		return orderMapper.selectDetailNum();
	}

	@Override
	public OrderDetailVO selectDetail(String detail_num) {
		return orderMapper.selectDetail(detail_num);
	}

	@Override
	public void statusAllChange(String orders_num, Integer orders_status) {
		orderMapper.statusAllChange(orders_num, orders_status);
	}

	@Override
	public int selectGiftCountPossible(String to_id) {
		return orderMapper.selectGiftCountPossible(to_id); 
	}


    /*
    // 스케줄링을 바로 실행할 테스트 메서드
    @Scheduled(initialDelay = 5000, fixedRate =  60000) // 5초 후에 실행하고, 그 후 1분마다 실행
    public void testScheduledTask() {
        // 스케줄링 작업 내용
        System.out.println("Scheduled task executed at " + LocalDateTime.now());
    }
	*/
}
