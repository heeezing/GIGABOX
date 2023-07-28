package kr.spring.member.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter  
@ToString
public class MemberVO {
	private int mem_num;//회원번호
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String mem_id;//아이디
	private String mem_nickname;//닉네임
	private int mem_auth;//등급
	@NotEmpty
	private String mem_name;//이름
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String mem_passwd;//비밀번호
	private String mem_phone;//전화번호
	@Email
	@NotEmpty
	private String mem_email;//이메일
	@Size(min=5,max=5)
	private String mem_zipcode;//우편번호
	@NotEmpty
	private String mem_address1;//주소
	@NotEmpty
	private String mem_address2;//상세주소
	private Date mem_reg_date;//가입일
	private String auto;//자동 로그인 처리에 필요함
	private String mem_au_id;//자동로그인때 사용되는 식별값
	private int membership_id;
}
