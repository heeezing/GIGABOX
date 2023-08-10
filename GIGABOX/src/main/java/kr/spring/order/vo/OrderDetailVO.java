package kr.spring.order.vo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"sn_photo"})
public class OrderDetailVO {
	private int detail_num; //주문상세번호
	private int sn_num; //상품번호
	private String sn_name; //상품명
	private byte[] sn_photo;
	private String sn_detail; //상품구성
	private int sn_price; //가격
	private int sn_dc_price; //할인가
	private int sn_total; //상품구매금액
	private int orders_quantity; //상품구매수량
	private int orders_num; //주문 번호
	
	//이미지를 byte[]로 변환 (BLOB처리)
	//주의) 폼에서 파일 업로드 파라미터네임은 반드시 upload로 지정해야 함. photo아님!!
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[] 변환
		setSn_photo(upload.getBytes());
	}
}
