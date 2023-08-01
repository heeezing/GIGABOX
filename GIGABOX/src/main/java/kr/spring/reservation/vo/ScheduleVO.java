package kr.spring.reservation.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleVO {
	private int sch_num; //상영시간표 번호
	private Date sch_date; //상영 날자
	private String sch_start; //상영 시작 시간
	private String sch_end; //상영 끝 시간
	
	
	private int hall_num; //극장 번호
	
	
	
	private int movie_num; //영화 번호
}
