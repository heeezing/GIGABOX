package kr.spring.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.hall.vo.HallVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.point.dao.PointMapper;
import kr.spring.reservation.dao.ReservationMapper;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

@Service
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	ReservationMapper reservationMapper;
	@Autowired
	private PointMapper pointMapper;
	
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

	@Override
	public List<TheaterVO> getTheaterList() {
		return reservationMapper.getTheaterList();
	}

	@Override
	public List<MovieVO> getMovieList() {
		return reservationMapper.getMovieList();
	}

	@Override
	public List<HallVO> getHallsByTheaterId(int th_num) {
	    return reservationMapper.getHallsByTheaterId(th_num);
	}

	@Override
	public void updateSchedule(ScheduleVO schedule) {
		reservationMapper.updateSchedule(schedule);
	}

	@Override
	public ScheduleVO selectSchedule(Integer sch_num) {
		return reservationMapper.selectSchedule(sch_num);
	}

	@Override
	public List<ScheduleVO> getScheduleList(Map<String,Object> map) {
		return reservationMapper.getScheduleList(map);
	}

	@Override
	public void insertRes(ReservationVO reservation) {
		reservationMapper.insertRes(reservation);
		// 포인트 사용 및 적립 
		pointMapper.insertResPoint(reservation);
		// 남은좌석수 수정
		reservationMapper.updateRemain(reservation);
	}

	@Override
	public ReservationVO selectRes(String res_num) {
		return reservationMapper.selectRes(res_num);
	}

	@Override
	public String selectResNum() {
		return reservationMapper.selectResNum();
	}

	@Override
	public List<String> getSeatsDB(Integer sch_num) {
		return reservationMapper.getSeatsDB(sch_num);
	}

	@Override
	public int selectSeats(Integer hall_num) {
		return reservationMapper.selectSeats(hall_num);
	}

	@Override
	public void deleteRes(ReservationVO reservation) {
		reservationMapper.deleteRes(reservation);
		// 남은좌석수 수정
		reservationMapper.updateRemain(reservation);
	}

	@Override
	public List<ReservationVO> selectResList(Map<String, Object> map) {
		return reservationMapper.selectResList(map);
	}

	@Override
	public int getTotalBySch(Integer sch_num) {
		return reservationMapper.getTotalBySch(sch_num);
	}

}
