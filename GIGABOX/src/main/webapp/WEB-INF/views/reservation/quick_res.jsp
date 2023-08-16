<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/reservation.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../reservation/quick_res.do">예매</a> 
		<a href="../reservation/quick_res.do">빠른예매</a>
	</div>
</div>
<div class="page-main">
	<div class="title">
		빠른예매
	</div>
	<form action="quick_res.do" id="quick_res" method="post">
		<div class="quick_resContent">
			<div class="dateSelect">
				<div class="date_area"> 
					<c:forEach var="date" items="${dateList}">
					 	<div class="year"><fmt:formatDate value="${date}" pattern="yyyy.MM"/></div>
					 	<fmt:formatDate var="pattern_date" value="${date}" pattern="yyyy-MM-dd"/>
					 	<button class="date-button" data-num="${pattern_date}">
					 		<div class="day-of-month"><fmt:formatDate value="${date}" pattern="d"/></div>
					 		<span class="day-of-week"><fmt:formatDate value="${date}" pattern="E"/></span>
					 	</button>
					 </c:forEach>
				 </div>
			
			
			
				<!-- <div class="august" style="left: 30px; z-index: 1; opacity: 1;">2023.08</div>
				<div class="september" style="left: 30px; z-index: 1; opacity: 1;">2023.09</div>
				<div class="date_area">
					<p>25·오늘</p>
					<p style="color:blue">26·내일</p>
					<p style="color:red">27·일</p>
					<p>28·월</p>
					<p>29·화</p>
					<p>30·수</p>
					<p>31·목</p>
					<p>1·금</p>
					<p style="color:blue">2·토</p>
					<p style="color:red">3·일</p>
					<p>4·월</p>
					<p>5·화</p>
					<p>6·수</p>
					<p>7·목</p>
				</div> -->
			</div>
			<div class="quick_resArea">
					<div class="movie_choice">
						<p class="title">영화</p>
						<div class="all-list">
							<ul>
								<c:forEach var="movie" items="${movieList}">
						            <li>
						            	<button type="button" class="btn">${movie.m_title}</button>
						            </li>
						        </c:forEach>
							</ul>
						</div>
					</div>
					<div class="theater-choice">
						<div class="title_area">
							<p class="title">극장</p>
						</div>
						<div class="all-list">
							<ul>
								<c:forEach var="theater" items="${theaterList}">
						            <li>
						            	<button type="button" class="btn">${theater.th_name}</button>
						            </li>
						        </c:forEach>
							</ul>
						</div>
					</div>
					<div class="time-choice">
						<div class="title_area">
							<p class="title">시간</p>
						</div>
						<div class="all-list">
							<ul class="timetable">
								<c:forEach var="schedule" items="${ScheduleList}">
						        	<li>
										<div class="sch_left">
											<p class="sch_start">${schedule.sch_start}</p>
											<p class="sch_end">~ ${schedule.sch_end}</p>
										</div>
										<p class="m_title">${schedule.m_title}</p>
										<div class="sch_right">
											<span class="hall_name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${schedule.hall_name}</span>
											<span class="seat_count">
												<span class="now">50</span>
												<span class="slash">/</span>
												<span class="all">120</span>
											</span>
										</div>
									</li>
						        </c:forEach>
							</ul>
						</div>
					</div>
				</div>
		</div>
		<input type="button" value="좌석선택" onclick="location.href='${pageContext.request.contextPath}/reservation/seat.do'">
	</form>
	<br>
	<br>
</div>