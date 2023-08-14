package kr.spring.reservation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

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
	public List<HallVO> getHallsByTheaterId(int th_num);
	// 상영시간표 목록 불러오기
	public List<ScheduleVO> getScheduleList(Map<String, Object> map);
	
	
	//상영 시간표 정보 가져오기
	@Select("SELECT * FROM schedule s JOIN hall h ON s.hall_num = h.hall_num JOIN movie m ON s.movie_num = m.movie_num JOIN theater th ON h.th_num = th.th_num WHERE sch_num=#{sch_num}")
	public ScheduleVO selectSchedule(Integer sch_num);
	// 상영시간표 수정
	public void updateSchedule(ScheduleVO schedule);
	// 상영시간표 삭제
	@Delete("DELETE FROM schedule WHERE sch_num=#{sch_num}")
	public void deleteSchedule(Integer sch_num);
	
}
