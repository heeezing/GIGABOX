package kr.spring.reservation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.hall.vo.HallVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

@Mapper
public interface ReservationMapper {
	//상영시간표글
	public List<ScheduleVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertSchedule(ScheduleVO schedule);
	
	// 영화 목록 불러오기
	@Select("SELECT * FROM movie ORDER BY movie_num")
	public List<MovieVO> getMovieList();
	// 극장 목록 불러오기
	@Select("SELECT * FROM theater ORDER BY th_num")
	public List<TheaterVO> getTheaterList();
	// 극장 선택 후 상영관
	@Select("SELECT * FROM hall h WHERE h.th_num = #{th_num} ORDER BY hall_name")
	public List<HallVO> getHallsByTheaterId(int theaterId);
	
	// 상영시간표 수정
	public void updateSchedule(ScheduleVO schedule);
}
