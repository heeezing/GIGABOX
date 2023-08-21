package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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
	
	//무비포스트 게시판
	public List<PostVO> selectPost(Map<String,Object> map);
	public int selectPostRowCount(Map<String,Object> map);
	
	//관리자-회원관리
	public List<MemberVO> selectMember(Map<String,Object> map);
	public int selectMemberRowCount(Map<String,Object> map);

}  
