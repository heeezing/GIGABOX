package kr.spring.main.service;

import java.util.List;

import kr.spring.cs.vo.CsVO;
import kr.spring.event.vo.EventVO;
import kr.spring.movie.vo.MovieVO;

public interface MainService {
	//박스오피스 - 주문 많은 순으로 영화 불러오기(상위 4개)
	public List<MovieVO> selectBoxOffice();
	//이벤트 정보 불러오기 (최신 6건)
	public List<EventVO> selectEvent();
	//공지사항 정보 불러오기 (최신 1건)
	public List<CsVO> selectNotice();
}
