package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.movie.vo.Review_FavVO;
import kr.spring.movie.vo.Review_ReportVO;

 

public interface MovieService {
	//영화목록
	public List<MovieVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	public List<MovieVO> selectPreList(Map<String,Object>map);
	public int selectRowCountPreList(Map<String,Object> map);
	public List<MovieVO> selectAdminList(Map<String,Object>map);
	public int selectRowCountAdminList(Map<String,Object>map);
	//영화등록
	public void registerMovie(MovieVO movie);
	//영화 상세페이지
	public MovieVO selectMovie(Integer movie_num);
	//영화수정
	public void updateMovie(MovieVO movie);
	//영화삭제
	public void deleteMovie(Integer movie_num);
	public void updateStatusMovie(Integer movie_num);
	public void updateStatusMovieCheck(String[] selectmovies);
	//영화예매순위
	public int reservationRankByMovie(Integer movie_num);
	
	//api정보 저장
	public void saveMovies(List<MovieVO> movielist);
	//api 중복체크
	public List<MovieVO> removeDuplicateMovies(List<MovieVO> movielist,List<String> existingMovieSeqList);
	public List<String> getExistingMovieSeqList();
	
	//댓글
	public List<ReviewVO> selectListReview(Map<String,Object> map);
	public int selectRowCountReview(Map<String,Object> map);
	public ReviewVO selectReview(Integer review_num);
	public void insertReview(ReviewVO review);
	public void updateReview(ReviewVO review);
	public void deleteReview(Integer review_num);
	public int selectReviewCount(Integer movie_num);
	
	//평점 평균 구하기
	public int averageRatingScore(Integer rating_score);
	
	//관람평 좋아요
	public Review_FavVO selectFav(Review_FavVO fav);
	public int selectFavCount(Review_FavVO fav);
	public void insertFav(Review_FavVO fav);
	public void deleteFav(Integer review_favnum);
	
	//관람평 신고하기
	public List<Review_ReportVO> selectListRepo(Map<String,Object> map);
	public int selectRowCountRepo(Map<String,Object> map);
	public Review_ReportVO selectRepo(Integer repo_num);
	public void insertRepo(Review_ReportVO repo);
	public void deleteRepo(Integer repo_num);
	public void deleteRepoCheck(String[] selectreports);
	//관람평 신고하기 유효성 검사
	public int selectCountReportByUser(@Param(value="mem_num") Integer mem_num, @Param(value="review_num") Integer review_num);
}
 