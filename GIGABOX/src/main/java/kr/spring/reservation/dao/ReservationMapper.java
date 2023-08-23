package kr.spring.reservation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.data.repository.query.Param;

import kr.spring.hall.vo.HallVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

@Mapper
public interface ReservationMapper {
	//상영시간표글
	public List<ScheduleVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void insertSchedule(ScheduleVO schedule);
	// 상영관 좌석수 불러오기
	@Select("SELECT seats FROM hall WHERE hall_num=#{hall_num}")
	public int selectSeats(Integer hall_num);
	// 해당 상영시간표 총 예매완료 수 구하기
	@Select("SELECT COUNT(*) FROM reservation WHERE sch_num=#{sch_num}")
	public int getTotalBySch(Integer sch_num);
	
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
	// 상영시간표 삭제를 위한 예약 삭제
	@Delete("DELETE FROM reservation r JOIN schedule s ON r.sch_num = s.sch_num WHERE sch_num=#{sch_num}")
	public void deleteResForSch(Integer sch_num);
	
	//주문번호 생성
	@Select("SELECT 'M' || TO_CHAR(SYSDATE, 'YYMMDD') || LPAD(reservation_seq.NEXTVAL, 6, '0') FROM dual")
	public String selectResNum();
	// 예매
	public void insertRes(ReservationVO reservation);
	// 남은좌석수 수정
	@Update("UPDATE schedule SET remain=#{remain} WHERE sch_num=#{sch_num}")
	public void updateRemain(ReservationVO reservation);
	//예매 내역 불러오기
	public ReservationVO selectRes(String res_num);
	
	// 예매완료된 좌석번호 불러오기
	@Select("SELECT res_seats FROM reservation WHERE sch_num=#{sch_num} AND res_status=1")
	public List<String> getSeatsDB(Integer sch_num);
	
	// 예매취소
	@Update("UPDATE reservation SET res_status=2, del_date=SYSDATE WHERE res_num=#{res_num}")
	public void deleteRes(String res_num);
	
	//관리자 - 전체 회원 예매 내역
	public List<ReservationVO> selectResList(Map<String, Object> map);
	
}
