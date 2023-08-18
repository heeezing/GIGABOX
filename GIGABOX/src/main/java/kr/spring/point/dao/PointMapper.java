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
	//스낵 구매 취소 시 포인트 환불
	@Insert("INSERT INTO point(pt_num,orders_num,mem_num,add_point,pt_detail) "
		  + "VALUES(point_seq.nextval,#{orders_num},#{mem_num},#{add_point},'포인트환불(주문취소)')")
	public void insertRefundPoint(PointVO pointVO);
	
	//나의 포인트 내역 레코드 수 - 마이페이지(페이지 처리 용)
	@Select("SELECT COUNT(*) FROM point WHERE mem_num=#{mem_num}")
	public int selectPointCountByMem_num(Map<String,Object> map);
	//나의 포인트 내역 목록 - 마이페이지
	@Select("SELECT * FROM point p LEFT OUTER JOIN orders o ON p.orders_num=o.orders_num "
			+ "                    LEFT OUTER JOIN reservation r ON p.res_num=r.res_num "
			+ "WHERE p.mem_num=#{mem_num} ORDER BY pt_num DESC")
	public List<PointVO> selectPointListByMem_num(Map<String,Object> map);
	//회원 별 총 보유 포인트 - 마이페이지, 주문, 예매에서 사용
	@Select("SELECT NVL(SUM(add_point) - SUM(use_point), 0) AS result FROM point WHERE mem_num = #{mem_num}")
	public int myTotalPoint(Integer mem_num);
	
	//[관리자] 회원 포인트 내역 레코드 수
	public int selectPointCount(Map<String,Object> map);
	//[관리자] 회원 포인트 내역 목록
	public List<PointVO> selectPointList(Map<String,Object> map);
}
