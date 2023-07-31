package kr.spring.membership.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.membership.vo.MembershipVO;

@Mapper
public interface MembershipMapper {
	//멤버십 관리 - 관리자
	//멤버십번호 생성
	@Select("SELECT membership_seq.nextval FROM dual")
	public int selectMembership_id();
	//멤버십등록
	@Insert("INSERT INTO membership (membership_id,membership_grade,membership_detail,price) VALUES (#{membership_id},#{membership_grade},#{membeship_detail},#{price})")
	public void insertMembership(MembershipVO membership);
	//멤버십 리스트
	public int selectRowCount(Map<String,Object> map);
	public List<MembershipVO> selectList(Map<String,Object> map);
	
}
