package kr.spring.movie.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MovieVO;
import kr.spring.movie.vo.ReviewVO;
import kr.spring.movie.vo.Review_FavVO;
import kr.spring.movie.vo.Review_ReportVO;

@Service
@Transactional
public class MovieServiceImpl implements MovieService{

	@Autowired
	MovieMapper moviemapper;


	@Override 
	public List<MovieVO> selectList(Map<String, Object> map) { 
		return moviemapper.selectList(map); 
	}


	@Override
	public void registerMovie(MovieVO movie) {
		moviemapper.registerMovie(movie);
	}

	@Override
	public MovieVO selectMovie(Integer movie_num) {
		return moviemapper.selectMovie(movie_num);
	}  

	@Override
	public void updateMovie(MovieVO movie) {
		moviemapper.updateMovie(movie);
	}

	@Override
	public void deleteMovie(Integer movie_num) {
		moviemapper.deleteMovie(movie_num);
	}
	
	@Override
	public void deleteMovieCheck(String[] selectmovies) {
		moviemapper.deleteMovieCheck(selectmovies);
		
	}


	@Override
	public int selectRowCount(Map<String, Object> map) {
		return moviemapper.selectRowCount(map);
	}


	@Override
	public List<ReviewVO> selectListReview(Map<String, Object> map) {
		return moviemapper.selectListReview(map);
	}


	@Override
	public int selectRowCountReview(Map<String, Object> map) {
		return moviemapper.selectRowCountReview(map);
	}


	@Override
	public void insertReview(ReviewVO review) {
		moviemapper.insertReview(review);
	}


	@Override
	public void updateReview(ReviewVO review) {
		moviemapper.updateReview(review);
	}


	@Override
	public void deleteReview(Integer review_num) {
		//부모글 좋아요 삭제
		moviemapper.deleteFavByReviewNum(review_num);
		//부모글 삭제(부모글: 관람평, 자식글: 관람평 좋아요)
		moviemapper.deleteReview(review_num);
	}


	@Override
	public int averageRatingScore(Integer rating_score) {
		return moviemapper.averageRatingScore(rating_score);
	}


	@Override
	public ReviewVO selectReview(Integer review_num) {
		return moviemapper.selectReview(review_num);
	}


	@Override
	public Review_FavVO selectFav(Review_FavVO fav) {
		return moviemapper.selectFav(fav);
	}


	@Override
	public int selectFavCount(Review_FavVO fav) {
		return moviemapper.selectFavCount(fav);
	}


	@Override
	public void insertFav(Review_FavVO fav) {
		moviemapper.insertFav(fav);
		
	}


	@Override
	public void deleteFav(Integer review_favnum) {
		moviemapper.deleteFav(review_favnum);	
	}


	@Override
	public List<Review_ReportVO> selectListRepo(Map<String, Object> map) {
		return moviemapper.selectListRepo(map);
	}


	@Override
	public Review_ReportVO selectRepo(Integer repo_num) {
		return moviemapper.selectRepo(repo_num);
	}


	@Override
	public void insertRepo(Review_ReportVO repo) {
		moviemapper.insertRepo(repo);
	}


	@Override
	public void deleteRepo(Integer repo_num) {
		moviemapper.deleteRepo(repo_num);
	}


	@Override
	public int selectRowCountRepo(Map<String, Object> map) {
		return moviemapper.selectRowCountRepo(map);
	}


	@Override
	public void deleteRepoCheck(String[] selectreports) {
		moviemapper.deleteRepoCheck(selectreports);
	}


	@Override
	public int selectCountReportByUser(@RequestParam(value="mem_num") Integer mem_num,@RequestParam(value="review_num") Integer review_num) {
		return moviemapper.selectCountReportByUser(mem_num, review_num);
	}


	@Override
	public void saveMovies(List<MovieVO> movielist) {
		
		for(MovieVO vo : movielist) {
			moviemapper.insertMovie(vo);
		}
	}


	@Override
	public List<MovieVO> removeDuplicateMovies(List<MovieVO> movielist,List<String> existingMovieSeqList) {
		Set<String> movieSeqSet = new HashSet<>();
	    List<MovieVO> uniqueMovies = new ArrayList<>();
			  
		    for (MovieVO vo : movielist) {
		        String movieSeq = vo.getMovieSeq();
	
		        if (!movieSeqSet.contains(movieSeq) && !existingMovieSeqList.contains(movieSeq)) {
		            movieSeqSet.add(movieSeq);
		            uniqueMovies.add(vo);
		        }
		    }

		    return uniqueMovies;
	}


	@Override
	public List<String> getExistingMovieSeqList() {
		return moviemapper.getExistingMovieSeqList();
	}


	@Override
	public int selectReviewCount(Integer movie_num) {
		return moviemapper.selectReviewCount(movie_num);
	}


	@Override
	public List<MovieVO> selectPreList(Map<String, Object> map) {
		return moviemapper.selectPreList(map);
	}
	
}




	

