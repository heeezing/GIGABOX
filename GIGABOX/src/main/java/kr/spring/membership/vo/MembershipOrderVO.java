package kr.spring.membership.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MembershipOrderVO {
	private int order_num; //주문번호
	private int mem_num;
	private int membership_id;
	private int price;
	private String pay_type;
	private Date pay_date;
	private Date next_pay_date;
	private String billing_key;
	private String result_status;
	private String result_message;
}
