package kr.spring.membership.service;

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
		membership.setMembership_id(membershipMapper.selectMembership_id());
		membershipMapper.insertMembership(membership);
	}

}
