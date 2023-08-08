package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	public void deleteMovie(Integer Movie_num) {
		// TODO Auto-generated method stub

	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return moviemapper.selectRowCount(map);
	}

	//@Override
	//public void saveMovies(MovieVO movielist) {
	//	 moviemapper.insertMovie(movielist);
	//	 moviemapper.saveMovies(movielist);
	//}


	//@Override
	//public void insertMovie(MovieVO movelist) {
	//	moviemapper.insertMovie(movelist);
		
	//}


}
