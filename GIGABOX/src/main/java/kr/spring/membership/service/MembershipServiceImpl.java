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
	public void insertMembership(MembershipVO membershipVO) {
		membershipMapper.insertMembership(membershipVO);
	}

	@Override
	public int selectMembershipCount(Map<String, Object> map) {
		return membershipMapper.selectMembershipCount(map);
	}

	@Override
	public List<MembershipVO> selectMembershipList(Map<String, Object> map) {
		return membershipMapper.selectMembershipList(map);
	}

	@Override
	public MembershipVO selectMembership(Integer membership_id) {
		return membershipMapper.selectMembership(membership_id);
	}

	@Override
	public void updateMembership(MembershipVO membershipVO) {
		membershipMapper.updateMembership(membershipVO);
	}

	@Override
	public void deleteMembership(Integer membership_id) {
		membershipMapper.deleteMembership(membership_id);
	}
	
	@Override
	public List<MembershipVO> selectMembershipUserList(Map<String, Object> map) {
		return membershipMapper.selectMembershipUserList(map);
	}


	@Override
	public MembershipVO getMembershipById(int membershipId) {
		return membershipMapper.getMembershipById(membershipId);
	}



	


}
