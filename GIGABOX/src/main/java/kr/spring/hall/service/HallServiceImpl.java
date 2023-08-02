package kr.spring.hall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.hall.dao.HallMapper;
import kr.spring.hall.vo.HallVO;
import kr.spring.theater.vo.TheaterVO;

@Service
@Transactional
public class HallServiceImpl implements HallService{
	
	@Autowired
	HallMapper hallMapper;

	@Override
	public void insertHall(HallVO hall) {
		hallMapper.insertHall(hall);
	}

	@Override
	public List<HallVO> selectList(Map<String, Object> map) {
		return hallMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return hallMapper.selectRowCount(map);
	}

	@Override
	public HallVO selectHall(Integer hall_num) {
		return hallMapper.selectHall(hall_num);
	}

	@Override
	public void updateHall(HallVO hall) {
		hallMapper.updateHall(hall);
	}

	@Override
	public void deleteHall(Integer hall_num) {
		hallMapper.deleteHall(hall_num);
	}

	@Override
	public List<TheaterVO> getTheaterList() {
		return hallMapper.getTheaterList();
	}

}
