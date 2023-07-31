package kr.spring.membership.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MembershipVO {
	private int membership_id; //멤버십 번호
	private String membership_grade; //멤버십 등급
	private String membership_detail; //멤버십 혜택
	private int price; //멤버십 가격
}
