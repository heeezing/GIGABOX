package kr.spring.snack.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.snack.dao.SnackMapper;
import kr.spring.snack.vo.SnackVO;

@Service
@Transactional
public class SnackServiceImpl implements SnackService{

	@Autowired
	SnackMapper snackMapper;
	
	@Override
	public void insertSnack(SnackVO snack) {
		snackMapper.insertSnack(snack);
	}

	@Override
	public int selectSnackCount(Map<String, Object> map) {
		return snackMapper.selectSnackCount(map);
	}

	@Override
	public List<SnackVO> selectSnackList(Map<String, Object> map) {
		return snackMapper.selectSnackList(map);
	}

	@Override
	public SnackVO selectSnack(Integer sn_num) {
		return snackMapper.selectSnack(sn_num);
	}

	@Override
	public void updateSnack(SnackVO snackVO) {
		snackMapper.updateSnack(snackVO);
	}

	@Override
	public void deleteSnack(Integer sn_num) {
		//장바구니 정보 삭제
		
		//상품 정보 삭제
		snackMapper.deleteSnack(sn_num);
	}

	@Override
	public void deleteChBox(String[] checkArr) {
		//장바구니 정보 삭제
		
		//상품 정보 삭제
		snackMapper.deleteChBox(checkArr);
	}

	@Override
	public int selectUserSnackCount(int sn_category) {
		return snackMapper.selectUserSnackCount(sn_category);
	}

	@Override
	public List<SnackVO> selectUserSnackList(Map<String,Object> map) {
		return snackMapper.selectUserSnackList(map);
	}

}
