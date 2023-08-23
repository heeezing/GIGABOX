package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;

@Mapper
public interface BoardMapper {
	//예매내역 게시판
	public List<ReservationVO> selectReservation(Map<String,Object> map);
	public int selectReservationRowCount(Map<String,Object> map);
	public int selectDelReservationRowCount(Map<String,Object> map);
	
	//구매내역 게시판
	public List<OrderVO> selectOrder(Map<String,Object> map);
	public int selectOrderRowCount(Map<String,Object> map);
	
	//리뷰내역 게시판
	public List<ReviewVO> selectReview(Map<String,Object> map);
	public int selectReviewRowCount(Map<String,Object> map);
	public void insertReview(ReviewVO review);
	
	//무비포스트 게시판
	public List<PostVO> selectPost(Map<String,Object> map);
	public int selectPostRowCount(Map<String,Object> map);
	
	//관리자-회원관리
	public List<MemberVO> selectMember(Map<String,Object> map);
	public int selectMemberRowCount(Map<String,Object> map);
	
	//문의내역 게시판
	public List<CsPersonalVO> selectCs(Map<String,Object> map);
	public int selectCsRowCount(Map<String,Object> map);
	
	//이벤트내역 게시판
	public List<EventVO> selectEvent(Map<String,Object> map);
	public int selectEventRowCount(Map<String,Object> map);
	
	//[사용자-마이페이지] 최근 3개 예매 목록
	@Select("SELECT * FROM (SELECT * FROM reservation WHERE mem_num=#{mem_num} ORDER BY res_num DESC) WHERE rownum <= 3")
	public List<ReservationVO> selectListReservationByMem_num3(Integer mem_num);
	//[사용자-마이페이지] 최근 3개 문의 목록
	@Select("SELECT * FROM (SELECT * FROM cs_personal WHERE mem_num=#{mem_num} ORDER BY personal_num DESC) WHERE rownum <= 3")
	public List<CsPersonalVO> selectListCsByMem_num3(Integer mem_num);
}  
