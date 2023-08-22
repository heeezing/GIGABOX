package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import kr.spring.cs.vo.CategoryVO;
import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventResultVO;
import kr.spring.event.vo.EventVO;

public interface EventService {
	//게시글
	public List<EventVO> selectEventList(Map<String,Object> map);
	public List<EventVO> selectEventMainList();
	public List<EventVO> selectEventTop10List();
	public List<CategoryVO> selectDetailCategoryList();

	public int selectRowCount(Map<String,Object> map);
	public void insertEvent(EventVO event);
	public EventVO selectEvent(Integer event_num);
	public void updateHit (Integer event_num);
	public void updateEvent(EventVO event);
	public void deleteEvent(Integer event_num);	
	
	public List<EventReplyVO> selectReplyList(Integer event_num);
	
	public void insertEventResult(EventResultVO eventResultVO);
	public EventResultVO selectEventResult(Integer event_num);
	public void updateEventResult(EventResultVO eventResultVO);
	public void deleteEventResult(Integer result_num);
	public void updateState0(Integer event_num);
	public void updateState1(Integer event_num);
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
