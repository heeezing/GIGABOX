package kr.spring.order.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderVO {
	private String orders_num; //주문번호
	private String sn_name; //주문대표상품명
	private int origin_total; //총 상품 금액(원가)
	private int orders_total; //총 상품 금액(할인가 포함)
	private int pay_total; //총 결제 금액
	private int payment; //결제 방식
	private int orders_type; //주문 타입 - 1:구매, 2:선물
	private int orders_status; //주문 및 사용 상태 - 1:미사용, 2:사용완료, 3:유효기간만료, 4:주문취소
	private Date orders_date; //주문일
	private Date valid_date; //사용만료일
	private Date modify_date; //주문수정일
	private String billing_key; //결제 빌링키
	
	//orders_type이 2(선물)인 경우 - 입력 받는 데이터
	private String from_id; //보내는 사람 아이디
	private String to_id; //받는 사람 아이디
	private String to_phone; //받는 사람 전화번호
	private String message; //보낼 메시지
	
	private int sn_num; //단건 구매 시 상품 번호
	private int orders_quantity; //단건 구매 시 개수
	
	private int mem_num; //구매자 회원번호
	private String id; //구매자 아이디
	private int use_point; //사용 포인트
	private int add_point; //적립 포인트
	
	private int[] cart_numbers; //장바구니에서 선택한 상품의 상품번호들
	
}
