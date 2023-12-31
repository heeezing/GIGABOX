package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.point.dao.PointMapper;
import kr.spring.point.vo.PointVO;

@Service
@Transactional
public class PointServiceImpl implements PointService{
	
	@Autowired
	private PointMapper pointMapper;

	@Override
	public int selectPointCountByMem_num(Map<String, Object> map) {
		return pointMapper.selectPointCountByMem_num(map);
	}

	@Override
	public List<PointVO> selectPointListByMem_num(Map<String, Object> map) {
		return pointMapper.selectPointListByMem_num(map);
	}

	@Override
	public int myTotalPoint(Integer mem_num) {
		return pointMapper.myTotalPoint(mem_num);
	}

	@Override
	public int selectPointCount(Map<String, Object> map) {
		return pointMapper.selectPointCount(map);
	}

	@Override
	public List<PointVO> selectPointList(Map<String, Object> map) {
		return pointMapper.selectPointList(map);
	}

	@Override
	public void insertWelcomePoint(Integer mem_num) {
		pointMapper.insertWelcomePoint(mem_num);
	}

	@Override
	public void insertRefundPoint(PointVO pointVO) {
		pointMapper.insertRefundPoint(pointVO);
	}

	@Override
	public PointVO selectResCancelPoint(String res_num) {
		return pointMapper.selectResCancelPoint(res_num);
	}

	@Override
	public void insertResRefundPoint(PointVO pointVO) {
		pointMapper.insertResRefundPoint(pointVO);
	}

	@Override
	public PointVO selectPointByOrders_num(String orders_num) {
		return pointMapper.selectPointByOrders_num(orders_num);
	}

	@Override
	public void minusAddPoint(PointVO pointVO) {
		pointMapper.minusAddPoint(pointVO);
	}

}
