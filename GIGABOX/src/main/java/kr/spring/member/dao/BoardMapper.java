package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.snack.vo.SnackVO;

@Mapper
public interface BoardMapper {
	//예매내역 게시판
	public List<ReservationVO> selectReservation(Map<String,Object> map);
	public int selectReservationRowCount(Map<String,Object> map);
	
	//구매내역 게시판
	public List<SnackVO> selectOrder(Map<String,Object> map);
	public int selectOrderRowCount(Map<String,Object> map);

}  
