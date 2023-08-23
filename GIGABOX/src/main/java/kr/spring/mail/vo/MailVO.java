package kr.spring.mail.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MailVO {
	private String email;
	private String title;
	private String content;
}
