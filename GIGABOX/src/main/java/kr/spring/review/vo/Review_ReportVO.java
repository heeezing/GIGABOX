package kr.spring.review.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.ToString;
import lombok.Setter;

@Getter
@Setter
@ToString
public class Review_ReportVO {
	private int repo_num;
	private int review_num;
	private int movie_num;
	private int mem_num;
	private Date repo_date;
}
