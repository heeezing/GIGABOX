package kr.spring.theater.vo;

import java.io.IOException;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"th_photo"})
public class TheaterVO {
	private int th_num; // 극장 번호
	private String th_name; // 극장명
	private String th_address; // 극장 주소
	private String th_phone; // 극장 전화번호
	private byte[] th_photo; // 극장 사진
	private String th_photoname;
	
	
	// ========= 이미지를 byte[]로 변환(BLOB 처리) ========= //
	public void setUpload(MultipartFile upload)throws IOException{
		// MultipartFile -> byte[]
		setTh_photo(upload.getBytes());
		// 파일 이름
		setTh_photoname(upload.getOriginalFilename());
	}
}
