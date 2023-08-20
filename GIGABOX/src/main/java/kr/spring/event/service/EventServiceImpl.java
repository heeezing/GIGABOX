package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cs.vo.CategoryVO;
import kr.spring.event.dao.EventMapper;
import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventResultVO;
import kr.spring.event.vo.EventVO;

@Service
@Transactional
public class EventServiceImpl implements EventService{
	
	@Autowired
	EventMapper eventMapper;
	

	@Override
	public List<EventVO> selectEventList(Map<String, Object> map) {
		return eventMapper.selectEventList(map);
	}
	
	@Override
	public List<EventVO> selectEventMainList() {
		return eventMapper.selectEventMainList();
	}
	@Override
	public List<EventVO> selectEventTop10List() {
		return eventMapper.selectEventTop10List();
	}
	@Override
	public List<CategoryVO> selectDetailCategoryList() {
		
		return eventMapper.selectDetailCategoryList();
	}


	@Override
	public int selectRowCount(Map<String, Object> map) {
		return eventMapper.selectRowCount(map);
	}

	@Override
	public void insertEvent(EventVO event) {
		eventMapper.insertEvent(event);
	}

	@Override
	public EventVO selectEvent(Integer event_num) {
		return eventMapper.selectEvent(event_num);
	}

	@Override
	public void updateHit(Integer event_num) {
		eventMapper.updateHit(event_num);
		
	}

	@Override
	public EventVO updateEvent(EventVO event) {
		return eventMapper.updateEvent(event);
	}

	@Override
	public void deleteEvent(Integer event_num) {
		eventMapper.deleteEvent(event_num);
	}

	@Override
	public List<EventReplyVO> selectListReply(Map<String, Object> map) {
		return eventMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return eventMapper.selectRowCountReply(map);
	}

	@Override
	public EventReplyVO selectReply(Integer reply_num) {
		return eventMapper.selectReply(reply_num);
	}

	@Override
	public void insertReply(EventReplyVO eventReply) {
		eventMapper.insertReply(eventReply);
	}

	@Override
	public void updateReply(EventReplyVO eventReply) {
		eventMapper.updateReply(eventReply);
	}

	@Override
	public void deleteReply(Integer reply_num) {
		eventMapper.deleteReply(reply_num);
	}

	@Override
	public void deleteReplyByEventNum(Integer event_num) {
		eventMapper.deleteReplyByEventNum(event_num);
		
	}

	@Override
	public boolean checkReply(EventReplyVO eventReply) {
		return eventMapper.checkReply(eventReply);
	}

	@Override
	public void insertEventResult(EventResultVO eventResultVO) {
		eventMapper.insertEventResult(eventResultVO);
	}

	@Override
	public void updateState0(Integer event_num) {
		eventMapper.updateState0(event_num);
		
	}

	@Override
	public void updateState1(Integer event_num) {
		eventMapper.updateState1(event_num);
		
	}

	@Override
	public EventResultVO selectEventResult(Integer event_num) {
		return eventMapper.selectEventResult(event_num);
	}

	@Override
	public void updateEventResult(EventResultVO eventResultVO) {
		eventMapper.updateEventResult(eventResultVO);
		
	}

	@Override
	public void deleteEventResult(Integer result_num) {
		eventMapper.deleteEventResult(result_num);
	}

	@Override
	public List<EventReplyVO> selectReplyList(Integer event_num) {
		return eventMapper.selectReplyList(event_num);
	}

}
