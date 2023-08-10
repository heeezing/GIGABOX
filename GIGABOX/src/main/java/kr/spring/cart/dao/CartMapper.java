package kr.spring.cart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cart.vo.CartVO;

@Mapper
public interface CartMapper {
	//장바구니에 상품 등록
	public void insertCart(CartVO cart);
	//회원번호(mem_num)별 총 구매 금액 - 할인가 포함
	public int selectTotalByMem_num(Map<String,Object> map);
	////회원번호(mem_num)별 총 구매 금액 - 원가
	public int selectOriginTotalByMem_num(Map<String,Object> map);
	//장바구니 목록
	public List<CartVO> selectListCart(Map<String,Object> map);
	//장바구니에 담은 상품 개수
	@Select("SELECT COUNT(*) FROM cart WHERE mem_num=#{mem_num}")
	public int selectCartCount(Integer mem_num);
	//장바구니 상세
	@Select("SELECT * FROM cart WHERE sn_num=#{sn_num} AND mem_num=#{mem_num}")
	public CartVO selectCart(CartVO cart);
	//장바구니 수정 (개별 상품 수량 수정)
	@Update("UPDATE cart SET orders_quantity=#{orders_quantity} WHERE cart_num=#{cart_num}")
	public void updateCart(CartVO cart);
	//장바구니 상품번호와 회원번호 별 수정
	@Update("UPDATE cart SET orders_quantity=#{orders_quantity} "
		  + "WHERE sn_num=#{sn_num} AND mem_num=#{mem_num}")
	public void updateCartBySn_num(CartVO cart);
	//장바구니 단일 삭제
	@Delete("DELETE FROM cart WHERE cart_num=#{cart_num}")
	public void deleteCart(Integer cart_num);
	//장바구니 다중 삭제
	public void deleteChBox(String[] checkArr);
	//상품 삭제 시 장바구니에 담겨있는 상품 삭제
	public void deleteCartBySn_num(Integer sn_num);
}
