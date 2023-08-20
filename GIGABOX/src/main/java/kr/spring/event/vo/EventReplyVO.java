package kr.spring.event.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventReplyVO {
private int reply_num, mem_num, event_num,th_num;
private String content;
private String ip;
private Date reg_date, modify_date;

private String id, th_name;
private String name,phone,email;
}
