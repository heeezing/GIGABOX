package kr.spring.theater.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.dao.TheaterMapper;
import kr.spring.theater.vo.TheaterVO;

@Service
@Transactional
public class TheaterServiceImpl implements TheaterService{
	@Autowired
	private TheaterMapper theaterMapper;
	
	@Override
	public void insertTheater(TheaterVO theater) {
		theaterMapper.insertTheater(theater);
	}

	@Override
	public List<TheaterVO> selectList(Map<String,Object> map) {
		return theaterMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return theaterMapper.selectRowCount(map);
	}

	@Override
	public TheaterVO selectTheater(int th_num) {
		return theaterMapper.selectTheater(th_num);
	}

	@Override
	public void updateTheater(TheaterVO theater) {
		theaterMapper.updateTheater(theater);
	}

	@Override
	public List<TheaterVO> selectTheaterList() {
		return theaterMapper.selectTheaterList();
	}

	@Override
	public List<ScheduleVO> selectScheduleList(Map<String,Object> map) {
		return theaterMapper.selectScheduleList(map);
	}



}
