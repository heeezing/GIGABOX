package kr.spring.movie.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.movie.vo.MovieVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.movie.vo.Review_FavVO;
import kr.spring.movie.vo.Review_ReportVO;
 
@Mapper
public interface MovieMapper {
	public List<MovieVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	public List<MovieVO> selectPreList(Map<String,Object>map);
	public int selectRowCountPreList(Map<String,Object> map);
	public List<MovieVO> selectAdminList(Map<String,Object>map);
	public int selectRowCountAdminList(Map<String,Object>map);
	//등록폼으로 영화 등록
	public void registerMovie(MovieVO movie);
	//api 불러오기
	public void insertMovie(MovieVO movie);
	//movie테이블의 movieSeq값 찾기
	@Select("SELECT movieSeq FROM movie")
	public List<String> getExistingMovieSeqList();
	@Select("SELECT * FROM movie WHERE movie_num=#{movie_num}")
	public MovieVO selectMovie(Integer movie_num);
	public void updateMovie(MovieVO movie);
	@Delete("DELETE FROM movie WHERE movie_num=#{movie_num}")
	public void deleteMovie(Integer movie_num);
	@Update("UPDATE movie SET m_status=3")
	public void updateStatusMovie(Integer movie_num);
	public void updateStatusMovieCheck(String[] selectmovies);
	//영화 예매 순위
	@Select("SELECT COALESCE(sub.rank, (SELECT COUNT(*) FROM movie)) AS rank FROM (SELECT s.movie_num, ROW_NUMBER() OVER (ORDER BY COALESCE(COUNT(r.res_num), 0) DESC) AS rank FROM schedule s LEFT JOIN reservation r ON s.sch_num = r.sch_num GROUP BY s.movie_num) sub WHERE sub.movie_num = #{movieNum}")
	public int reservationRankByMovie(Integer movie_num);
	
	
	//관람평
	public List<ReviewVO> selectListReview(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM review WHERE movie_num= #{movie_num}")
	public int selectRowCountReview(Map<String,Object> map);
	@Select("SELECT r.*,m.m_title,me.id FROM review r JOIN movie m ON r.movie_num=m.movie_num JOIN member me ON r.mem_num = me.mem_num WHERE review_num=#{review_num}")
	public ReviewVO selectReview(Integer review_num);
	public void insertReview(ReviewVO review);
	@Update("UPDATE review SET review_content=#{review_content},rating_score=#{rating_score},review_mdate=SYSDATE WHERE review_num=#{review_num}")
	public void updateReview(ReviewVO review);
	@Delete("DELETE FROM review WHERE review_num=#{review_num}")
	public void deleteReview(Integer review_num);
	@Select("SELECT COALESCE(COUNT(*), 0) AS review_cnt FROM review WHERE movie_num = #{movie_num} GROUP BY movie_num")
	public int selectReviewCount(Integer movie_num);
	
	//평점 평균 구하기
	@Select("SELECT COALESCE(round(AVG(rating_score), 1), 0) AS rating_avg FROM review WHERE movie_num = #{movie_num}")
	public int averageRatingScore(Integer rating_score);
	
	//관람평 좋아요
	@Select("SELECT * FROM review_fav WHERE review_num=#{review_num} AND mem_num=#{mem_num} AND movie_num=#{movie_num}")
	public Review_FavVO selectFav(Review_FavVO fav);
	@Select("SELECT COUNT(*) FROM review_fav WHERE review_num=#{review_num} AND movie_num=#{movie_num}")
	public int selectFavCount(Review_FavVO fav);
	@Insert("INSERT INTO review_fav(review_favnum,review_num,mem_num,movie_num) VALUES (review_fav_seq.nextval,#{review_num},#{mem_num},#{movie_num})")
	public void insertFav(Review_FavVO fav);
	@Delete("DELETE FROM review_fav WHERE review_favnum=#{review_favnum}")
	public void deleteFav(Integer review_favnum);
	@Delete("DELETE FROM review_fav WHERE review_num=#{review_num}")
	public void deleteFavByReviewNum(Integer review_num);
	
	//관람평 신고하기
	public List<Review_ReportVO> selectListRepo(Map<String,Object> map);
	public int selectRowCountRepo(Map<String,Object> map);
	@Select("SELECT * FROM review_report WHERE review_num=#{review_num}")
	public Review_ReportVO selectRepo(Integer repo_num);
	@Insert("INSERT INTO review_report(repo_num,review_num,mem_num,movie_num,repo_date) VALUES (review_report_seq.nextval,#{review_num},#{mem_num},#{movie_num},SYSDATE)")
	public void insertRepo(Review_ReportVO repo);
	@Delete("DELETE FROM review_report WHERE repo_num=#{repo_num}")
	public void deleteRepo(Integer repo_num);
	public void deleteRepoCheck(String[] selectreports);
	@Delete("DELETE FROM review_report WHERE review_num=#{review_num}")
	public void deleteRepoByReviewNum(Integer review_num);
	//관람평 신고 유효성 검사
	@Select("SELECT COUNT(*) FROM review_report WHERE mem_num=#{mem_num} AND review_num=#{review_num}")
	public int selectCountReportByUser(@Param(value="mem_num") Integer mem_num, @Param(value="review_num") Integer review_num);
}
