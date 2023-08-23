package kr.spring.hall.service;

import java.util.List;
import java.util.Map;

import kr.spring.hall.vo.HallVO;
import kr.spring.theater.vo.TheaterVO;

public interface HallService {
	// 상영관 등록
	public void insertHall(HallVO hall);
	// 상영관 목록
	public List<HallVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	// 상영관 선택
	public HallVO selectHall(Integer hall_num);
	// 상영관 수정
	public void updateHall(HallVO hall);
	
	// 극장 목록 불러오기
	public List<TheaterVO> getTheaterList();
}
