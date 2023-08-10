package kr.spring.post.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Post_ReplyVO {
	private int re_num;
	private int post_num;
	private int mem_num;
	private String re_content;
	private Date re_date;
	private Date re_mdate;
}
