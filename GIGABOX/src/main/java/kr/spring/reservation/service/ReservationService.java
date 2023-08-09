package kr.spring.reservation.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import kr.spring.hall.vo.HallVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

@Service
public interface ReservationService {
	//상영시간표글
	public List<ScheduleVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertSchedule(ScheduleVO schedule);
	
	// 영화 목록 불러오기
	public List<MovieVO> getMovieList();
	// 극장 목록 불러오기
	public List<TheaterVO> getTheaterList();
	// 극장 선택 후 상영관
	public List<HallVO> getHallsByTheaterId(int th_num);
	
	//상영 시간표 정보 가져오기
	public ScheduleVO selectSchedule(Integer sch_num);
	// 상영시간표 수정
	public void updateSchedule(ScheduleVO schedule);
	// 상영시간표 삭제
	public void deleteSchedule(Integer sch_num);
}
