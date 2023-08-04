package kr.spring.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.spring.reservation.vo.ScheduleVO;

@Service
public interface ReservationService {
	//상영시간표글
	public List<ScheduleVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertSchedule(ScheduleVO schedule);
}
