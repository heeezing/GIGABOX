package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cs.vo.CategoryVO;
import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventResultVO;
import kr.spring.event.vo.EventVO;

@Mapper
public interface EventMapper {
//게시글
	//게시글 리스트 
	public List<EventVO> selectEventList(Map<String,Object> map);
	//게시글 갯수
	public int selectRowCount(Map<String,Object> map);
	
	//진행중인 이벤트 메인 이미지 리스트 
	public List<EventVO> selectEventMainList();
	public List<EventVO> selectEventTop10List();
	public List<CategoryVO> selectDetailCategoryList();
	
	//게시글 작성
	public void insertEvent(EventVO event);
	//게시글 하나 선택
	@Select("SELECT * FROM event WHERE event_num = #{event_num}")
	public EventVO selectEvent(Integer event_num);
	//조회수 올리기
	@Update("UPDATE event SET count=count+1 WHERE event_num=#{event_num}")
	public void updateHit (Integer event_num);
	//게시글 수정하기
	//이미지는 어떻게 수정하면 좋을까..?
	@Update("UPDATE event SET category_num=#{category_num}, category_detail_num=#{category_detail_num}, event_form_type=#{event_form_type},thumb1 = #{thumb1},thumb1_name = #{thumb1_name},thumb2 = #{thumb2}, thumb2_name = #{thumb2_name}, title=#{title}, content=#{content}, event_start = TO_DATE(#{event_start},'YYYY-MM-DD'),event_end = TO_DATE(#{event_end},'YYYY-MM-DD'), modify_date=SYSDATE WHERE event_num=#{event_num}")
	public void updateEvent(EventVO event);
	//게시글 삭제하기
	@Delete("DELETE FROM event WHERE event_num = #{event_num}")
	public void deleteEvent(Integer event_num);	
	@Insert("INSERT INTO event_result (result_num, mem_num, event_num, title, content ,reg_date) VALUES (event_result_seq.nextval, #{mem_num}, #{event_num}, #{title}, #{content}, SYSDATE)")
	public void insertEventResult(EventResultVO eventResultVO);
	@Select("SELECT * FROM event_result WHERE event_num = #{event_num}")
	public EventResultVO selectEventResult(Integer event_num);
	@Update("UPDATE event_result SET title=#{title}, content=#{content}, modify_date = SYSDATE WHERE result_num = #{result_num}")
	public void updateEventResult(EventResultVO eventResultVO);
	@Delete("DELETE FROM event_result WHERE result_num=#{result_num}")
	public void deleteEventResult(Integer result_num);
	@Update("UPDATE event SET state = 0 WHERE event_num=#{event_num}")
	public void updateState0(Integer event_num);
	@Update("UPDATE event SET state = 1 WHERE event_num=#{event_num}")
	public void updateState1(Integer event_num);
	public List<EventReplyVO> selectReplyList(Integer event_num);
	//댓글
	public List<EventReplyVO> selectListReply(Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object> map);
	public EventReplyVO selectReply(Integer reply_num);
	public boolean checkReply(EventReplyVO eventReply);
	public void insertReply(EventReplyVO eventReply);
	public void updateReply(EventReplyVO eventReply);
	public void deleteReply(Integer reply_num);
	public void deleteReplyByEventNum(Integer event_num);
	
}
