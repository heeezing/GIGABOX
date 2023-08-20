package kr.spring.cs.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CsPersonalVO {
	
	private int personal_num, th_num, mem_num,category_num;
	private String email, title, content;
	private Date reg_date, modify_date;
	private int state;
	private MultipartFile[] files;
	
	private int rnum, answer_num;
	private String th_name,category_name;
}
