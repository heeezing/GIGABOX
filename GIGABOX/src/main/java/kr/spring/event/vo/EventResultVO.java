package kr.spring.event.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventResultVO {
	
	private int result_num,mem_num,event_num;
	private String title, content;
	private Date reg_date,modify_date;
	
}
