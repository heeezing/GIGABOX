package kr.spring.movie.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"m_poster","m_stillimg","m_vod"})
public class MovieVO {
	private int movie_num; //영화 번호
	private int m_rank; //영화 순위(박스오피스)
	private String m_title; //영화 제목
	private String m_titleEng; //영화 영문 제목
	private String m_director; //감독명
	private String m_actor; //배우명
	private String m_nation; //제작국가
	private String m_company;//제작사
	private String m_plot;//줄거리
	private  int m_runtime;//상영시간
	private String m_rating; //관람등급
	private String m_genre; //장르
	private Date m_opendate; //개봉일
	private byte[] m_poster; //포스터 //poster
	private String m_poster_name;
	private byte[] m_stillimg;//스틸컷 //stillimg
	private String m_stillimg_name;
	private Date m_date;//등록일
	private byte[] m_vod;//예고편 //vod
	private String m_vod_name;
	
	//이미지를 byte[]로 변환
	public void setUpload(MultipartFile poster) throws IOException{
		//MultipartFiled -> byte[]
		setM_poster(poster.getBytes());
		//파일이름
		setM_poster_name(poster.getOriginalFilename());
	}
	
	public void setUpload2(MultipartFile stillimg) throws IOException{
		setM_stillimg(stillimg.getBytes());
		setM_stillimg_name(stillimg.getOriginalFilename());
	}
	
	public void setUpload3(MultipartFile vod) throws IOException{
		setM_vod(vod.getBytes());
		setM_vod_name(vod.getOriginalFilename());
	}
}
