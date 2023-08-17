package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.BoardMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.review.vo.ReviewVO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<ReservationVO> selectReservation(Map<String, Object> map) {
		return boardMapper.selectReservation(map);
	}

	@Override
	public int selectReservationRowCount(Map<String, Object> map) {
		return boardMapper.selectReservationRowCount(map);
	}

	@Override
	public List<OrderVO> selectOrder(Map<String, Object> map) {
		return boardMapper.selectOrder(map); 
	}

	@Override
	public int selectOrderRowCount(Map<String, Object> map) {
		return boardMapper.selectOrderRowCount(map);
	}

	@Override
	public List<ReviewVO> selectReview(Map<String, Object> map) {
		return boardMapper.selectReview(map);
	}

	@Override
	public int selectReviewRowCount(Map<String, Object> map) {
		return boardMapper.selectReviewRowCount(map);
	}

	@Override
	public List<PostVO> selectPost(Map<String, Object> map) {
		return boardMapper.selectPost(map);
	}

	@Override
	public int selectPostRowCount(Map<String, Object> map) {
		return boardMapper.selectPostRowCount(map);
	}


}  
