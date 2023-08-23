package kr.spring.reservation.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationVO {
	private String res_num; //예매 번호
	private Date res_date; //예매 날짜
	private Date del_date; //예매 취소 날짜
	private int res_people; //예매 인원
	private String res_payment; //결제수단
	private int res_total; //결제금액
	private int res_status; //예매 결제 상태 (1:결제 완료 2:취소)
	private String res_seats; // 좌석번호
	
	private String m_title;//영화 이름
	private String th_name;//극장
	private String hall_name;//상영관
	private String sch_date; //상영날짜
	private String sch_start; //상영시작시간
	private String phone; //회원전화번호
	private String name; //회원이름
	private String m_poster2; // 포스터(api)
	
	private int sch_num;
	private int mem_num;
	private int movie_num;
	
	private int add_point; // 적립 포인트
	private int use_point; // 사용 포인트
	
	private int remain; // 남은 좌석수 계산
}
