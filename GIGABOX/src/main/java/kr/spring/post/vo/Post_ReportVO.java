package kr.spring.post.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Post_ReportVO {
	private int repo_post_num;
	private int post_num;
	private int mem_num;
	private Date repo_post_date;
}
