package kr.spring.movie.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.movie.vo.MovieVO;
 
@Mapper
public interface MovieMapper {
	public List<MovieVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	public void registerMovie(MovieVO movie);
	//public void insertMovie(MovieVO movielist);
	@Select("SELECT * FROM movie WHERE movie_num=#{movie_num}")
	public MovieVO selectMovie(Integer movie_num);
	@Update("UPDATE movie SET m_title=#{m_title},m_titleEng=#{m_titleEng},m_director=#{m_director},m_actor=#{m_actor},m_company=#{m_company},m_plot=#{m_plot},m_runtime=#{m_runtime},m_rating=#{m_rating},m_genre=#{m_genre},m_opendate=#{m_opendate},m_poster=#{m_poster},poster_name=#{poster_name},m_stllimg=#{m_stllimg},stllimg_name=#{stllimg_name},m_vod=#{m_vod},m_nation=#{m_nation},m_status=#{m_status}"
			+ "WHERE movie_num=#{movie_num}")
	public void updateMovie(MovieVO movie);
	public void deleteMovie(Integer Movie_num);
	
	//api
	//public void saveMovies(MovieVO movielist);
}
