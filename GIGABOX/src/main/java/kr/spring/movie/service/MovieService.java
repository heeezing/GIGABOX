package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.spring.movie.vo.MovieVO;


public interface MovieService {
	public List<MovieVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	public void insertMovie(MovieVO movie);
	public MovieVO selectMovie(Integer movie_num);
	public void updateMovie(MovieVO movie);
	public void deleteMovie(Integer Movie_num);
}
