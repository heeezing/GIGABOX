package kr.spring.movie.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review_FavVO {
	private int review_favnum;
	private int review_num;
	private int movie_num;
	private int mem_num;
}
