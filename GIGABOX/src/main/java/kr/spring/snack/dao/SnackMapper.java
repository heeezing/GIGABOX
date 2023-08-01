package kr.spring.snack.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.snack.vo.SnackVO;

@Mapper
public interface SnackMapper {
	//상품 등록
	public void insertSnack(SnackVO snack);
	//전체or검색 상품 개수
	public int selectSnackCount(Map<String,Object> map);
	//전체or검색 상품 목록
	public List<SnackVO> selectSnackList(Map<String,Object> map);
	//상품 상세
	@Select("SELECT * FROM snack WHERE sn_num=#{sn_num}")
	public SnackVO selectSnack(Integer sn_num);
	//상품 수정
	public void updateSnack(SnackVO snackVO);
	//상품 단일 삭제
	@Delete("DELETE FROM snack WHERE sn_num=#{sn_num}")
	public void deleteSnack(Integer sn_num);
	//상품 다중 삭제
	public void deleteChBox(String[] checkArr);
}
