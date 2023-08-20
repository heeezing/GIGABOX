<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>

<!-- 기존댓글 그대로..  -->
<div class="page-main">
	<div class="event-detail">
	    <h2 class="tit">${event.title}</h2>
	    <p class="event-detail-date">
	        <span>기간</span>
	        <em> ${event.event_start} ~ ${event.event_end}</em>
	    </p>
	    <div class="detail-info">
		${event.content}
		</div>
	</div>
	<c:if test="${event.event_form_type == 2}">
	<script src="${pageContext.request.contextPath}/js/event_reply.js"></script>
		<!-- 댓글 UI 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="event_num" value="${event.event_num}" id="event_num">
			<select id="theater" name="th_num" class="small ml10" <c:if test="${empty user}">disabled="disabled"</c:if>>
					<option value="0">영화관</option>
					<c:forEach var="th" items="${theater}">
						<option value="${th.th_num}">${th.th_name}</option>
					</c:forEach>
			</select>
			<textarea rows="3" cols="50" name="content"
			  id="re_content" class="rep-content"
			  <c:if test="${empty user}">disabled="disabled"</c:if>
			  ><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>                                               
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="re_second" class="align-right">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif"
		   width="100" height="100">
	</div>
	<!-- 댓글 UI 끝 -->
		
	</c:if>
</div>
