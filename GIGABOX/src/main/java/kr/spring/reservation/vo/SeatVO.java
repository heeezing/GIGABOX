package kr.spring.reservation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatVO {
	private int seat_num; //좌석번호
	private String seat_name; //좌석이름
	private int seat_status; //좌석 선택 가능 여부(1:가능, 2:불가능)
	
	private int hall_num; //극장 번호
}
