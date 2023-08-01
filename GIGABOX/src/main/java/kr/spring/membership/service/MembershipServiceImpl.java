package kr.spring.membership.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.membership.dao.MembershipMapper;
import kr.spring.membership.vo.MembershipVO;

@Service
@Transactional
public class MembershipServiceImpl implements MembershipService{
	
	@Autowired
	private MembershipMapper membershipMapper;

	@Override
	public void insertMembership(MembershipVO membership) {
		membershipMapper.insertMembership(membership);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return membershipMapper.selectRowCount(map);
	}

	@Override
	public List<MembershipVO> selectList(Map<String, Object> map) {
		return membershipMapper.selectList(map);
	}

	@Override
	public void updateMembership(MembershipVO membership) {
		membershipMapper.updateMembership(membership);
	}

	@Override
	public void deleteMembership(Integer membership_id) {
		membershipMapper.deleteMembership(membership_id);
	}

	@Override
	public MembershipVO selectMembership(Integer membership_id) {
		return membershipMapper.selectMembership(membership_id);
	}

}
