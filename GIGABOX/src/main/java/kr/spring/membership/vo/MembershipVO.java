package kr.spring.membership.vo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"photo"})
public class MembershipVO {
	private int membership_id; //멤버십 번호
	private String membership_grade; //멤버십 등급
	private String membership_benefits; //멤버십 혜택
	private int price; //멤버십 가격
	private byte[] photo;
	private String photo_name;
	private String membership_detail;
	
	//업로드 파일 처리
	public void setUpload(MultipartFile upload)
			throws IOException{
		//MultipartFile -> byte[] 변환
		setPhoto(upload.getBytes());
		//파일명 구하기
		setPhoto_name(upload.getOriginalFilename());
	}
}
