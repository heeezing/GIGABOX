package kr.spring.reservation.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationVO {
	private int res_num; //예매 번호
	private Date res_date; //예매 날짜
	private int res_people; //예매 인원
	private String res_payment; //결제수단
	private int res_total; //결제금액
	private int res_status; //예매 결제 상태 (1:결제 완료 2:취소)
	private String res_seats; // 좌석번호
	
	private int sch_num;
	private int mem_num;
}
