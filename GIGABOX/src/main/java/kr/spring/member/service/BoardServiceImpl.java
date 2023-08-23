package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.event.vo.EventVO;
import kr.spring.member.dao.BoardMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;

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
	public int selectDelReservationRowCount(Map<String, Object> map) {
		return boardMapper.selectDelReservationRowCount(map);
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
	public void insertReview(ReviewVO review) {
		boardMapper.insertReview(review);
	}

	@Override
	public List<PostVO> selectPost(Map<String, Object> map) {
		return boardMapper.selectPost(map);
	}

	@Override
	public int selectPostRowCount(Map<String, Object> map) {
		return boardMapper.selectPostRowCount(map);
	}

	@Override
	public List<MemberVO> selectMember(Map<String, Object> map) {
		return boardMapper.selectMember(map);
	}

	@Override
	public int selectMemberRowCount(Map<String, Object> map) {
		return boardMapper.selectMemberRowCount(map);
	}

	@Override
	public List<CsPersonalVO> selectCs(Map<String, Object> map) {
		return boardMapper.selectCs(map);
	}

	@Override
	public int selectCsRowCount(Map<String, Object> map) {
		return boardMapper.selectCsRowCount(map);
	}

	@Override
	public List<ReservationVO> selectListReservationByMem_num3(Integer mem_num) {
		return boardMapper.selectListReservationByMem_num3(mem_num);
	}

	@Override
	public List<CsPersonalVO> selectListCsByMem_num3(Integer mem_num) {
		return boardMapper.selectListCsByMem_num3(mem_num);
	}

	@Override
	public List<EventVO> selectEvent(Map<String, Object> map) {
		return boardMapper.selectEvent(map);
	}

	@Override
	public int selectEventRowCount(Map<String, Object> map) {
		return boardMapper.selectEventRowCount(map);
	}



}  
