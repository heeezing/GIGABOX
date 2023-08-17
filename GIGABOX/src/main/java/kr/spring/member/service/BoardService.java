package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;
import kr.spring.order.vo.OrderVO;
import kr.spring.post.vo.PostVO;
import kr.spring.reservation.vo.ReservationVO;
import kr.spring.review.vo.ReviewVO;

public interface BoardService{
	//예매내역 게시판
	public List<ReservationVO> selectReservation(Map<String,Object> map);
	public int selectReservationRowCount(Map<String,Object> map);
	
	//구매내역 게시판
	public List<OrderVO> selectOrder(Map<String,Object> map);
	public int selectOrderRowCount(Map<String,Object> map);
	
	//리뷰내역 게시판
	public List<ReviewVO> selectReview(Map<String,Object> map);
	public int selectReviewRowCount(Map<String,Object> map);
	
	//무비포스트 게시판
	public List<PostVO> selectPost(Map<String,Object> map);
	public int selectPostRowCount(Map<String,Object> map);
}
  