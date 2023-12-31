package kr.spring.reservation.vo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleVO {
	private int sch_num; //상영시간표 번호
	private String sch_date; //상영 날자
	private String sch_start; //상영 시작 시간
	private String sch_end; //상영 끝 시간
	
	private int th_num; //극장 번호
	private int hall_num; //상영관 번호
	private int movie_num; //영화 번호
	private String m_poster2; // 영화 포스터(api)
	private byte[] m_poster;
	private String poster_name;
	private String m_title;//영화 이름
	private String th_name;//극장
	private String hall_name;//상영관
	private int seats;//좌석수
	private int remain;//남은 좌석수
	private String m_runtime; // 상영시간
	
	public void setPoster(MultipartFile poster) throws IOException{
		//MultipartFile -> byte[] 변환
		setM_poster(poster.getBytes());
		//파일명 구하기
		setPoster_name(poster.getOriginalFilename());
	}
	
}
