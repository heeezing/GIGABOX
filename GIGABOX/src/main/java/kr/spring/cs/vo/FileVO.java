package kr.spring.cs.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileVO {

	private int file_num; //파일 번호
	private int personal_num; //게시글 번호
	private String origin_name; //원본 파일 이름
	private String save_name; //저장 파일 이름
	private Long file_size; //파일 크기 
	
	

	
}
