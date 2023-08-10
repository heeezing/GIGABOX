package kr.spring.cart.vo;

import java.sql.Date;

import kr.spring.snack.vo.SnackVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {
	private int cart_num; //장바구니 번호
	private int sn_num; //상품 번호
	private int orders_quantity; //주문 상품 수
	private Date reg_date; //등록일
	private int mem_num; //회원 번호
	
	private int sub_total; //동일 상품의 합계 금액(할인가 포함)
	private int sub_real_total; //동일 상품의 합계 금액(원가)
	private SnackVO snackVO;
}
