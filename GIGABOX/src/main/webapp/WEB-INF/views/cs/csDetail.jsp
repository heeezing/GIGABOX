<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>

<!-- csNoti만 사용한다.  -->
<div class="page-main">
	<div class="event-detail">
	    <h2 class="tit">${cs.title}</h2>
	    <p class="event-detail-date">
	        <span>작성일</span>
	        <em> ${cs.reg_date}</em>
	    </p>
	    <div class="detail-info">
		${cs.content}
		</div>
	</div>
	
    <div class="btn-group pt40">
    	 <button class="button purple large" onclick="location.href='csNotiList.do'">목록</button>
    <c:if test="${ user.auth == 9 }">
         <button class="button purple large" onclick="location.href='csModify.do?modify_num=${cs.noti_num}&table=2'">수정</button>
         <button class="button purple large" onclick="location.href='csDelete.do?delete_num=${cs.noti_num}&table=2'">삭제</button>
    </c:if>
    </div>
   
    
</div>