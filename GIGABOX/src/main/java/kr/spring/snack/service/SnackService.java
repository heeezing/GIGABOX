package kr.spring.snack.service;

import java.util.List;
import java.util.Map;

import kr.spring.snack.vo.SnackVO;

public interface SnackService {
	/*==========관리자==========*/
	//상품 등록
	public void insertSnack(SnackVO snack);
	//전체or검색 상품 개수
	public int selectSnackCount(Map<String,Object> map);
	//전체or검색 상품 목록
	public List<SnackVO> selectSnackList(Map<String,Object> map);
	//상품 상세
	public SnackVO selectSnack(Integer sn_num);
	//상품 수정
	public void updateSnack(SnackVO snackVO);
	//상품 삭제 (+장바구니 삭제)
	public void deleteSnack(Integer sn_num);
	//상품 다중 삭제
	public void deleteChBox(String[] checkArr);
	
	/*==========사용자==========*/
	//카테고리 별 상품 개수
	public int selectUserSnackCount(int sn_category);
	//카테고리 별 상품 목록
	public List<SnackVO> selectUserSnackList(Map<String,Object> map);
	
}
