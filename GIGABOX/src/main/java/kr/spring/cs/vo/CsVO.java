package kr.spring.cs.vo;

import java.sql.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//cs_qna, cs_noti 게시판의 데이터를 옮길 때 사용합니다. 
public class CsVO {
	private int qna_num, mem_num, category_num, th_num;
	private String title,content;
	private Date reg_date,modify_date;
	
	private int noti_num;
	private String category_name,th_name;
}
