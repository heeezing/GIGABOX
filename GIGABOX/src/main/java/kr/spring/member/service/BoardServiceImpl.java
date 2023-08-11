package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.BoardMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.snack.vo.SnackVO;

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
	public List<SnackVO> selectOrder(Map<String, Object> map) {
		return boardMapper.selectOrder(map);
	}

	@Override
	public int selectOrderRowCount(Map<String, Object> map) {
		return boardMapper.selectOrderRowCount(map);
	}


}  
