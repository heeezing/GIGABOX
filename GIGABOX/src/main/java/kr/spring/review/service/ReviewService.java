package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import kr.spring.review.vo.ReviewVO;

public interface ReviewService {
	public List<ReviewVO> selectList(Map<String,Object> map);
	public int selectRowCountReview(Map<String,Object> map);
	public void insertReview(ReviewVO review);
	public void updateReview(ReviewVO review);
	public void deleteReview(Integer review_num);
	
	//평점 평균 구하기
	public int averageRatingScore(Integer rating_score);
}
