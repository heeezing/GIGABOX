package kr.spring.hall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.hall.vo.HallVO;
import kr.spring.theater.vo.TheaterVO;

@Mapper
public interface HallMapper {
	// 상영관 등록
	public void insertHall(HallVO hall);
	// 상영관 목록
	public List<HallVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	// 상영관 선택
	@Select("SELECT * FROM hall WHERE hall_num=#{hall_num}")
	public HallVO selectHall(Integer hall_num);
	// 상영관 수정
	@Update("UPDATE hall SET hall_name=#{hall_name},th_num=#{th_num},hall_status=#{hall_status} WHERE hall_num=#{hall_num}")
	public void updateHall(HallVO hall);
	// 상영관 삭제
	@Delete("DELETE FROM hall WHERE hall_num=#{hall_num}")
	public void deleteHall(Integer hall_num);
	
	// 극장 목록 불러오기
	public List<TheaterVO> getTheaterList();
}
