package kr.spring.membership.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MembershipVO {
	private int membership_id;
	private String membership_grade;
	private String membership_detail;
	private int price;
}
