package kr.spring.movie.vo;

import java.sql.Date;

import kr.spring.util.DurationFromNow;
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
	private String review_date;
	private String review_mdate;
	
	private String m_title;
	private String id;
	private String nick_name;
	
	private int fav_cnt; //좋아요 개수
	
	public void  setReview_date(String review_date) {
		this.review_date = DurationFromNow.getTimeDiffLabel(review_date);
	}
	public void setReview_mdate(String review_mdate) {
		this.review_mdate = DurationFromNow.getTimeDiffLabel(review_mdate);
	}
}
