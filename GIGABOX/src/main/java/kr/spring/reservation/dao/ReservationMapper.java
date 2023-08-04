package kr.spring.reservation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.reservation.vo.ScheduleVO;

@Mapper
public interface ReservationMapper {
	//상영시간표글
	public List<ScheduleVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertSchedule(ScheduleVO schedule);
}
