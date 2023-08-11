package kr.spring.theater.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.reservation.vo.ScheduleVO;
import kr.spring.theater.vo.TheaterVO;

@Mapper
public interface TheaterMapper {
	// 관리자
	// 극장 등록
	public void insertTheater(TheaterVO theater);
	// 극장 목록
	public List<TheaterVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	// 극장 선택
	@Select("SELECT * FROM theater WHERE th_num=#{th_num}")
	public TheaterVO selectTheater(int th_num);
	// 극장 수정
	public void updateTheater(TheaterVO theater);
	// 극장 삭제
	@Delete("DELETE FROM theater WHERE th_num=#{th_num}")
	public void deleteTheater(int th_num);
	
	// 극장 정보 보기
	@Select("SELECT * FROM theater")
	public List<TheaterVO> selectTheaterList();
	
	// 상영시간표
	// 상영시간표 목록
	public List<ScheduleVO> selectScheduleList(Map<String,Object> map);
	
	
}