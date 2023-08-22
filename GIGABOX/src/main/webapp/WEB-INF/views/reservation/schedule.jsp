<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/theater.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/theaterDetail.js"></script>
<div class="page-util">
   <div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../reservation/quick_res.do">예매</a> 
		<a href="../reservation/schedule.do">상영시간표</a>
   </div>
</div>
<div class="page-main">
	<!-- 극장 선택 목록 시작 -->
	<div class="theater-choice-area">
		<div class="choice-main">
			<b><span>원하는 극장 선택</span></b>
		</div>
		<div class="theater-list-section">
			<ul class="theater-list">
				<c:forEach var="theater" items="${list}">
				<c:if test="${theater.th_num != 101}">
				<li>
					<button class="th-name" data-num="${theater.th_num}" onclick="selectTheater(this)">${theater.th_name}</button>
				</li>
				</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!-- 극장 선택 목록 끝 -->
	<!-- 극장 정보 시작 -->
	<div class="wrap-theater">
		<h1><span id="info_title"></span> <span id="info_title_sub">상영시간표</span></h1>
	</div>
	<!-- 극장 정보 끝 -->
	<!-- 상영시간표 시작 -->
	<div class="time-schedule-wrap">
		<div class="date-area">
			 <c:set var="today" value="${dateList[0]}"/>
			 <div class="year"><fmt:formatDate value="${today}" pattern="yyyy.MM"/></div>
			 <c:forEach var="date" items="${dateList}">
			 	<fmt:formatDate var="pattern_date" value="${date}" pattern="yyyy-MM-dd"/>
			 	<button class="date-button" data-num="${pattern_date}" onclick="selectDate(this)">
			 		<div class="day-of-month"><fmt:formatDate value="${date}" pattern="d"/></div>
			 		<span class="day-of-week"><fmt:formatDate value="${date}" pattern="E"/></span>
			 	</button>
			 </c:forEach>
		</div>
		<!-- 상영시간표 목록 출력 -->
		<div id="schedule_list_area"></div>
	</div>
	<!-- 상영시간표 끝 -->
</div>