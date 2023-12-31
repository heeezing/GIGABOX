package kr.spring.point.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.order.vo.OrderVO;
import kr.spring.point.vo.PointVO;
import kr.spring.reservation.vo.ReservationVO;

@Mapper
public interface PointMapper {
	//회원가입 시 포인트 적립 - member에서 사용
	@Insert("INSERT INTO point (pt_num, mem_num, add_point, pt_detail) VALUES (point_seq.nextval, #{mem_num}, 3000, '가입 축하 포인트')")
	public void insertWelcomePoint(Integer mem_num);
	//영화 예매 시 포인트 적립 및 사용 - reservation에서 사용
	public void insertResPoint(ReservationVO reservationVO);
	//스낵 구매 시 포인트 적립 및 사용 - order에서 사용
	public void insertSnackPoint(OrderVO orderVO);
	
	//스낵 구매 취소 시 해당 주문의 최초 적립/사용 포인트 체크
	@Select("SELECT * FROM point WHERE orders_num=#{orders_num} AND pt_detail NOT LIKE '%' || '취소'")
	public PointVO selectPointByOrders_num(String orders_num);
	//스낵 구매 전체 취소 시 사용 포인트 환불 및 적립 포인트 회수
	@Insert("INSERT INTO point(pt_num,orders_num,mem_num,add_point,use_point,pt_detail) "
		  + "VALUES(point_seq.nextval,#{orders_num},#{mem_num},#{add_point},#{use_point},'스낵 전체 취소')")
	public void insertRefundPoint(PointVO pointVO);
	//스낵 구매 부분 취소 시 적립 포인트 회수
	@Insert("INSERT INTO point(pt_num,orders_num,detail_num,mem_num,use_point,pt_detail) "
		  + "VALUES(point_seq.nextval,#{orders_num},#{detail_num},#{mem_num},#{use_point},'스낵 부분 취소')")
	public void minusAddPoint(PointVO pointVO);
	
	//영화 예매 취소 시 해당 주문의 적립/사용 포인트 체크
	@Select("SELECT * FROM point WHERE res_num=#{res_num}")
	public PointVO selectResCancelPoint(String res_num);
	//영화 예매 취소 시 포인트 환불
	@Insert("INSERT INTO point(pt_num,res_num,mem_num,add_point,use_point,pt_detail) "
			+ "VALUES(point_seq.nextval,#{res_num},#{mem_num},#{add_point},#{use_point},'영화 예매 취소')")
	public void insertResRefundPoint(PointVO pointVO);
	
	//나의 포인트 내역 레코드 수 - 마이페이지(페이지 처리 용)
	@Select("SELECT COUNT(*) FROM point WHERE mem_num=#{mem_num}") 
	public int selectPointCountByMem_num(Map<String,Object> map);
	//나의 포인트 내역 목록 - 마이페이지
	public List<PointVO> selectPointListByMem_num(Map<String,Object> map);
	
	//회원 별 총 보유 포인트 - 마이페이지, 주문, 예매에서 사용
	@Select("SELECT NVL(SUM(add_point) - SUM(use_point), 0) AS result FROM point WHERE mem_num = #{mem_num}")
	public int myTotalPoint(Integer mem_num);
	
	//[관리자] 회원 포인트 내역 레코드 수
	public int selectPointCount(Map<String,Object> map);
	//[관리자] 회원 포인트 내역 목록
	public List<PointVO> selectPointList(Map<String,Object> map);
}
