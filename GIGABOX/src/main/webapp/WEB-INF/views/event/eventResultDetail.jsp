<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>

<div class="page-main">
	<div class="event-detail">
	    <h2 class="tit">${event.title}</h2>
	    <p class="event-detail-date">
	        <span>작성일</span>
	        <em> ${event.reg_date}</em>
	    </p>
	    <div class="detail-info">
		${event.content}
		</div>
	</div>
	<c:if test="${user.mem_num == event.mem_num || user.auth == 9 }">
    <div class="btn-group pt40">
         <button class="button purple large" onclick="location.href='eventResultUpdate.do?event_num=${event.event_num}'">수정</button>
         <button class="button purple large" onclick="location.href='eventResultDelete.do?event_num=${event.event_num}'">삭제</button>
    </div>
    </c:if>
</div>