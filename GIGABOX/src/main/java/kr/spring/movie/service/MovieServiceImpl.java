package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MovieVO;

@Service
@Transactional
public class MovieServiceImpl implements MovieService{
	
	@Autowired
	MovieMapper moviemapper;

	@Override
	public List<MovieVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMovie(MovieVO movie) {
		moviemapper.insertMovie(movie);
		
	}

	@Override
	public MovieVO selectMovie(Integer movie_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMovie(MovieVO movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMovie(Integer Movie_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
}
