package kr.spring.event.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString(exclude = {"thumb1","thumb2","content"})
public class EventVO {
	private int event_num,mem_num,category_num;
	private int category_detail_num;
	private int event_form_type; //1:기본, 2:댓글, 3:스탬프
	//이후 수정
	private byte[] thumb1;
	private byte[] thumb2;
	private String thumb1_name;
	private String thumb2_name;
	private String title;
	private String content;
	private Date event_start, event_end, reg_date;
	private Date modify_date;
	private int state;
	private int count;
	//---추가--
	private String category_name,category_detail_name;
	private int rnum;
	
	public void setUpload1 (MultipartFile upload1) throws IOException{
		//멀티파트 파일을 바이트 배열로 변환한다. 
		setThumb1(upload1.getBytes());
		//파일명을 구한다. 
		setThumb1_name(upload1.getOriginalFilename());
	}
	public void setUpload2(MultipartFile upload2) throws IOException{
		//멀티파트 파일을 바이트 배열로 변환한다. 
		setThumb2(upload2.getBytes());
		//파일명을 구한다. 
		setThumb2_name(upload2.getOriginalFilename());
	}
	
	
}
