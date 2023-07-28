package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;

public interface AdminService {
	//회원관리 - 관리자
		public int selectRowCount(Map<String,Object> map);
		public List<MemberVO> selectList(Map<String,Object> map);
		public void updateByAdmin(MemberVO memberVO);
}
