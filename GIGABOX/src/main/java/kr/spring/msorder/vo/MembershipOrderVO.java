package kr.spring.msorder.vo;

import java.sql.Date;

import kr.spring.member.vo.MemberVO;
import kr.spring.membership.vo.MembershipVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MembershipOrderVO {
	private int order_num; //주문번호
	private int mem_num; //회원번호
	private int membership_id; //멤버십 번호
	private int price; //가격
	private String pay_type; //지불방식
	private Date pay_date; //결제일
	private Date next_pay_date; //다음 결제일
	private String billing_key; //빌링키
	private String result_status; //결제 상태
	private String result_message; //결과 메시지
	private String membership_grade; //멤버십 등급
	
	private MembershipVO membershipVO;
	private MemberVO memberVO;
}
