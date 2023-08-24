<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>

<div class="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
                <a href="eventList.do" title="이벤트 메인 페이지로 이동">이벤트</a>
                <a href="eventList.do" title="진행중 이벤트 페이지로 이동">진행중 이벤트</a>
			</div>
		</div>
	</div>
	<div id="contents">
		<div class="inner-wrap">
				<h2 class="tit">진행중인 이벤트</h2>
				<div class="tab-list fixed">
					<ul>
						<li id="eventTab_0"><a href="eventList.do" title="전체">전체</a></li>
						
						<c:forEach var="event3" items="${list3}">
						<li id="eventTab_${event3.category_num}"><a href="eventActiList.do?detail=${event3.category_num}" title="메가Pick 탭으로 이동">${event3.category_name}</a></li>
						</c:forEach>
					</ul>
				</div>
		</div>
		<div id="boardSearch" class="inner-wrap" style="">
				<div class="board-list-util mt40">
				<p class="result-count"><strong>전체 <b>${count}</b>건</strong></p>
				<div class="board-search">
					<form action="eventActiList.do" style="border:none; padding:0;" >
						<input type="hidden" name="detail" value="${detail}"/>
						<input type="text" name="keyword" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
						<button type="submit" class="btn-search-input">검색</button>
					</form>
				</div>
			</div>
		</div>
		<div id="event-list-wrap">
			<div class="inner-wrap">
						<div class="event-list mt15">
				        	<ul>
				        	<c:forEach var="event" items="${list}">
				        		<li>
				        			<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}" data-no="${event.event_num}" data-netfunnel="N" class="eventBtn" title="${event.title}">
									<p class="img"> <img src="${pageContext.request.contextPath}/event/imageView.do?thumb=${event.event_num}&thumb_type=1" ></p>
									<p class="tit">
									${event.title}
									</p>
									<p class="date">
									${event.event_start}~${event.event_end}
									</p>
									</a>
				        		</li>
				        	</c:forEach>
				        	</ul>
				       </div>
			</div>
		</div>
</div>
</div>