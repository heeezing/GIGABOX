package kr.spring.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	public List<MovieVO> selectList(Map<String,Object>map);
	public void insertMovie(MovieVO movie);
	public MovieVO selectMovie(Integer movie_num);
	public void updateMovie(MovieVO movie);
	public void deleteMovie(Integer Movie_num);
}
