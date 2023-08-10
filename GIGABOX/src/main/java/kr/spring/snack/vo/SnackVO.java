package kr.spring.snack.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"sn_photo"})
public class SnackVO {
	private int sn_num;
	private String sn_name;
	private String sn_detail;
	private int sn_price;
	private int sn_dc_price;
	private int sn_quantity;
	private byte[] sn_photo;
	private String sn_photo_name;
	private String sn_info;
	private int sn_category; //1:콤보, 2:팝콘, 3:음료, 4:스낵
	private Date sn_reg_date;
	private Date sn_modify_date;
	private int sn_status; //1:판매중지, 2:판매중
	private String sn_notice;
	
	//이미지를 byte[]로 변환 (BLOB처리)
	//주의) 폼에서 파일 업로드 파라미터네임은 반드시 upload로 지정해야 함. photo아님!!
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[] 변환
		setSn_photo(upload.getBytes());
		//파일명 저장
		setSn_photo_name(upload.getOriginalFilename());
	}
}
