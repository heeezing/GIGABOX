package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.order.vo.OrderVO;
import kr.spring.point.dao.PointMapper;
import kr.spring.point.vo.PointVO;

@Service
@Transactional
public class PointServiceImpl implements PointService{
	
	@Autowired
	private PointMapper pointMapper;

	@Override
	public int selectPointCountByMem_num(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PointVO> selectPointListByMem_num(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
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

}
