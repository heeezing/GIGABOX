package kr.spring.post.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude= {"post_photo"})
public class PostVO {
	private int post_num;
	private int movie_num;
	private int mem_num;
	private String post_content;
	private Date post_date;
	private Date post_mdate;
	private byte[] post_photo;
	private String post_name;
	private String post_title;
}
