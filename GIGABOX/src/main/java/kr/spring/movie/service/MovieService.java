package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import kr.spring.movie.vo.MovieVO;
 

public interface MovieService {
	//영화목록
	public List<MovieVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	//영화등록
	public void registerMovie(MovieVO movie);
	//영화 상세페이지
	public MovieVO selectMovie(Integer movie_num);
	//영화수정
	public void updateMovie(MovieVO movie);
	//영화삭제
	public void deleteMovie(Integer movie_num);
	public void deleteMovieCheck(String[] selectmovies);
	
	//api정보 저장
	//public void saveMovies(MovieVO movielist);
	//api정보 불러오기
	//public void insertMovie(MovieVO movelist);
}
 