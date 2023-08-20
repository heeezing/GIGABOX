<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="page-main">
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
            <div> <!-- 첨부파일 시작 -->
            <c:forEach var="file" items="${files}">
            	<a href='<c:url value="/filedownload?file_num=${file.file_num}"/>'>${file.origin_name}(사이즈:${file.file_size }kb)</a>
            </c:forEach>
            </div><!-- 첨부파일 끝 -->
            <c:if test="${user.mem_num == cs.mem_num }">
            <div class="btn-group pt40">
            	 <c:if test="${cs.state == 0 }">
            	 <button class="button purple large" onclick="location.href='csPersonalAdminWrite.do?personal_num=${cs.personal_num}'">답변</button>
            	 </c:if>  
                <button class="button purple large" onclick="location.href='csPersonalList.do'">목록</button>
                <button class="button purple large" onclick="location.href='csPersonalDelete.do?personal_num=${cs.personal_num}'">삭제</button>
           </div>
           </c:if>
        </div>
        
        <c:if test="${cs.state == 1 }">   
        <div class="event-detail">
             <h2 class="tit">${answer.title}</h2>
            <p class="event-detail-date">
                <span>작성일</span>
                <em> ${answer.reg_date}</em>
            </p>
            <div class="detail-info">
            ${answer.content}
            </div>
        </div>
        <c:if test="${user.auth ==  9 }">
        <div class="btn-group pt40">
                    <button class="button purple large" onclick="location.href='csPersonalAdminUpdate.do?personal_num=${cs.personal_num}'">수정</button>
                    <button class="button purple large" onclick="location.href='csPersonalAdminDelete.do?personal_num=${cs.personal_num}'">삭제</button>
        </div>
        </c:if>
        </c:if>
    </div>
    
</div>