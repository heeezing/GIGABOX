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
	private String id;//아이디
	private String nick_name;//닉네임
	private int auth;//등급
	@NotEmpty
	private String name;//이름
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String passwd;//비밀번호
	private String phone;//전화번호
	@Email
	@NotEmpty
	private String email;//이메일
	@Size(min=5,max=5)
	private String zipcode;//우편번호
	@NotEmpty
	private String address1;//주소
	@NotEmpty
	private String address2;//상세주소
	private Date reg_date;//가입일
	private String auto;//자동 로그인 처리에 필요함
	private String au_id;//자동로그인때 사용되는 식별값
	private int membership_id;
	
	//비밀번호 일치 여부 체크
	public boolean isCheckedPassword(String userPasswd) {
		if(auth > 1 && passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}
}
