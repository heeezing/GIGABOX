package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.review.dao.ReviewMapper;
import kr.spring.review.vo.ReviewVO;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewMapper reviewMapper;

	@Override
	public List<ReviewVO> selectList(Map<String, Object> map) {
		return reviewMapper.selectList(map);
	}

	@Override
	public int selectRowCountReview(Map<String, Object> map) {
		return reviewMapper.selectRowCountReview(map);
	}

	@Override
	public void insertReview(ReviewVO review) {
		reviewMapper.insertReview(review);
		
	}

	@Override
	public void updateReview(ReviewVO review) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReview(Integer review_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int averageRatingScore(Integer rating_score) {
		// TODO Auto-generated method stub
		return 0;
	}

}
