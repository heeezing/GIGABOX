package kr.spring.hall.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HallVO {
	private int hall_num; // 상영관 번호
	private String hall_name; // 상영관명
	private int hall_status; // 상영 가능 여부
	private int th_num; // 극장 번호
	private int seats; // 좌석수
	
	private String th_name; // 극장명
}
