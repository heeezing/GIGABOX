package kr.spring.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {
	private int detail_num; //주문상세번호
	private int sn_num; //상품번호
	private String sn_name; //상품명
	private String sn_detail; //상품구성
	private int sn_price; //가격
	private int sn_dc_price; //할인가
	private int sn_total; //상품구매금액
	private int orders_quantity; //상품구매수량
	private String orders_num; //주문 번호
	
}
