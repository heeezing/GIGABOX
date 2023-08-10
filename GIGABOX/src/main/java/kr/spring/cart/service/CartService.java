package kr.spring.cart.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.cart.vo.CartVO;

public interface CartService {
	//장바구니에 상품 등록
	public void insertCart(CartVO cart);
	//회원번호(mem_num)별 총 구매 금액 - 할인가 포함
	public int selectTotalByMem_num(Map<String,Object> map);
	////회원번호(mem_num)별 총 구매 금액 - 원가
	public int selectOriginTotalByMem_num(Map<String,Object> map);
	//장바구니 목록
	public List<CartVO> selectListCart(Map<String,Object> map);
	//장바구니에 담은 상품 개수
	public int selectCartCount(Integer mem_num);
	//장바구니 상세
	public CartVO selectCart(CartVO cart);
	//장바구니 수정 (개별 상품 수량 수정)
	public void updateCart(CartVO cart);
	//장바구니 상품번호와 회원번호 별 수정
	public void updateCartBySn_num(CartVO cart);
	//장바구니 단일 삭제
	public void deleteCart(Integer cart_num);
	//장바구니 다중 삭제
	public void deleteChBox(String[] checkArr);
}
