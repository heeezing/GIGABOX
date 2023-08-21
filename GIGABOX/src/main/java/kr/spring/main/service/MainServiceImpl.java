package kr.spring.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cs.vo.CsVO;
import kr.spring.event.vo.EventVO;
import kr.spring.main.dao.MainMapper;
import kr.spring.movie.vo.MovieVO;

@Service
@Transactional
public class MainServiceImpl implements MainService{

	@Autowired
	private MainMapper mainMapper;
	
	@Override
	public List<MovieVO> selectBoxOffice() {
		return mainMapper.selectBoxOffice();
	}

	@Override
	public List<MovieVO> selectAllMovie() {
		return mainMapper.selectAllMovie();
	}

	@Override
	public List<EventVO> selectEvent() {
		return mainMapper.selectEvent();
	}

	@Override
	public List<CsVO> selectNotice() {
		return mainMapper.selectNotice();
	}

}
