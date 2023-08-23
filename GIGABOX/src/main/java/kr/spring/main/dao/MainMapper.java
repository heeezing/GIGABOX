package kr.spring.main.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cs.vo.CsVO;
import kr.spring.event.vo.EventVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MainMapper {
	//박스오피스 - 주문 많은 순으로 영화 불러오기
	public List<MovieVO> selectBoxOffice();
	//영화 정보 불러오기 (임시로,,,)
	@Select("SELECT movie_num,m_plot,m_rating,m_title,m_runtime FROM movie WHERE rownum <= 4 ORDER BY movie_num")
	public List<MovieVO> selectAllMovie();
	//이벤트 정보 불러오기 (최신 4건)
	@Select("SELECT event_num,title,event_start,event_end FROM event WHERE rownum <= 6 ORDER BY event_num DESC")
	public List<EventVO> selectEvent();
	//공지사항 정보 불러오기 (최신 1건)
	@Select("SELECT noti_num,title FROM (SELECT * FROM cs_noti ORDER BY reg_date DESC) WHERE rownum = 1")
	public List<CsVO> selectNotice();
	
	
}
