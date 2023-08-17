package kr.spring.movie.vo;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"m_poster","m_stillimg"})
public class MovieVO {
	private int movie_num; //영화번호
	private int m_rank; //박스오피스 순위
	private Date m_date; //수정일
	private List<MovieVO> movielist;
		private String m_title;
		private String m_titleEng;
		private String m_director;
		private String m_actor;
		private String m_company;
		private String m_plot;
		private String m_runtime;
		private String m_rating;
		private String m_genre;
		private Date m_opendate;
		private String m_opendate2; //api..
		private byte[] m_poster;
		private String m_poster2; //api...
		private String poster_name;
		private byte[] m_stllimg;
		private String m_stllimg2; //api...
		private String stllimg_name;
		private String m_vod;
		private String m_nation;
		private int m_status;
		
		private int review_cnt; //관람평 개수
		
		private int rating_avg; //평점 평균 아니 이거 잘못됨 없앨거임 
		
		/*
		//평점 평균 구하기
		public int setratingAverage(int[] ratingscore) {
			//평점 배열(임시!!!!!!!)
			int[] avg = {}; //ratingscore.split(","); //ratingscore는 array. review작성할때 입력받음.
			
			//합계 계산
			int sum = 0;
			for(int num:avg) {
				sum += num;
			}
			
			//평균 계산
			double average = sum / avg.length;
			int rating_avg = (int)Math.round(average);
			
			return rating_avg;
		}
		*/
		
		
		
		//업로드 파일 처리
		public void setPoster(MultipartFile poster) throws IOException{
			//MultipartFile -> byte[] 변환
			setM_poster(poster.getBytes());
			//파일명 구하기
			setPoster_name(poster.getOriginalFilename());
		}
		public void setStllimg(MultipartFile stllimg) throws IOException{
			//MultipartFile -> byte[] 변환
			setM_stllimg(stllimg.getBytes());
			//파일명 구하기
			setStllimg_name(stllimg.getOriginalFilename());
		}	
	
	
}
