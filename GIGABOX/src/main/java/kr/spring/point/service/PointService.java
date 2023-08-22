package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.point.vo.PointVO;

public interface PointService {
	//회원가입 시 포인트 적립 - member에서 사용
	public void insertWelcomePoint(Integer mem_num);
	//나의 포인트 내역 레코드 수
	public int selectPointCountByMem_num(Map<String,Object> map);
	//나의 포인트 내역 목록
	public List<PointVO> selectPointListByMem_num(Map<String,Object> map);
	//회원 별 총 보유 포인트
	public int myTotalPoint(Integer mem_num);
	
	//스낵 구매 취소 시 해당 주문의 적립/사용 포인트 체크
	public PointVO selectCancelPoint(String orders_num);
	//스낵 구매 취소 시 포인트 환불
	public void insertRefundPoint(PointVO pointVO);
	
	//[관리자] 회원 포인트 내역 레코드 수
	public int selectPointCount(Map<String,Object> map);
	//[관리자] 회원 포인트 내역 목록
	public List<PointVO> selectPointList(Map<String,Object> map);
}
