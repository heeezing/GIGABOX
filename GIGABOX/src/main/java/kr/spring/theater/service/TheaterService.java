package kr.spring.theater.service;

import java.util.List;
import java.util.Map;

import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

public interface TheaterService {
	// 관리자
	// 극장 등록
	public void insertTheater(TheaterVO theater);
	// 극장 목록
	public List<TheaterVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	// 극장 상세
	public TheaterVO selectTheater(int th_num);
	// 극장 수정
	public void updateTheater(TheaterVO theater);
	// 극장 삭제
	public void deleteTheater(int th_num);

	// 극장 정보 보기
	// 극장 목록
	public List<TheaterVO> selectTheaterList();
	
	
	// 상영시간표
	// 상영시간표 목록
	public List<ScheduleVO> selectScheduleList(Map<String,Object> map);
}
