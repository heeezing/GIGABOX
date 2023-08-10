package kr.spring.order.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"sn_photo"})
public class OrderVO {
	private int orders_num; //주문번호
	private String sn_name; //주문대표상품명
	private byte[] sn_photo; //주문대표사진
	private int orders_total; //총 구매 금액
	private int payment; //결제 방식
	private int orders_type; //주문 타입 - 1:구매, 2:선물
	private int orders_status; //주문 및 사용 상태 - 1:주문완료(미사용), 2:주문완료(사용), 3:주문취소
	private Date orders_date; //주문일
	private Date valid_date; //사용만료일
	private Date modify_date; //주문수정일
	private String billing_key; //결제 빌링키
	
	//orders_type이 2(선물)인 경우 - 입력 받는 데이터
	private String to_id; //받는 사람 아이다
	private String to_phone; //받는 사람 전화번호
	private String message; //보낼 메시지
	
	private int mem_num; //구매자 회원번호
	private String id; //구매자 아이디
	
	private int[] cart_numbers; //장바구니에서 선택한 상품의 상품번호들
	
	//이미지를 byte[]로 변환 (BLOB처리)
	//주의) 폼에서 파일 업로드 파라미터네임은 반드시 upload로 지정해야 함. photo아님!!
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[] 변환
		setSn_photo(upload.getBytes());
	}
}
