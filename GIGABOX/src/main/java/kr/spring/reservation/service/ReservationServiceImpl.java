package kr.spring.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.reservation.dao.ReservationMapper;
import kr.spring.reservation.vo.ScheduleVO;

@Service
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	ReservationMapper reservationMapper;
	
	@Override
	public List<ScheduleVO> selectList(Map<String, Object> map) {
		return reservationMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return reservationMapper.selectRowCount(map);
	}

	@Override
	public void insertSchedule(ScheduleVO schedule) {
		reservationMapper.insertSchedule(schedule);
	}

}
