package kr.spring.review.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewVO {
	private int review_num;
	private int movie_num;
	private int mem_num;
	private int rating_score;
	private String review_content;
	private Date review_date;
	private Date review_mdate;
}
