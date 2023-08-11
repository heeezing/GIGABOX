package kr.spring.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.review.vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	public List<ReviewVO> selectList(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM review WHERE movie_num= #{movie_num}")
	public int selectRowCountReview(Map<String,Object> map);
	public void insertReview(ReviewVO review);
	public void updateReview(ReviewVO review);
	public void deleteReview(Integer review_num);
	
	//평점 평균 구하기
	public int averageRatingScore(Integer rating_score);
}
