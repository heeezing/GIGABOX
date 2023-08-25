<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/reservation.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reservation.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;"
			onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span>
		<a href="../reservation/quick_res.do">예매</a> <a
			href="../reservation/quick_res.do">빠른예매</a>
	</div>
</div>
<div class="page-main" id="speed_reservation">
	<div class="title">빠른예매</div>
	<form action="quick_res.do" id="quick_res" method="post">
		<div class="quick_resContent">
			<div class="dateSelect">
				<div class="date_area">
					<c:set var="today" value="${dateList[0]}" />
					<div class="year">
						<fmt:formatDate value="${today}" pattern="yyyy.MM" />
					</div>
					<c:forEach var="date" items="${dateList}">
						<fmt:formatDate var="pattern_date" value="${date}"
							pattern="yyyy-MM-dd" />
						<button class="date-button" data-num="${pattern_date}"
							>
							<div class="day-of-month">
								<fmt:formatDate value="${date}" pattern="d" />
							</div>
							&nbsp; <span class="day-of-week"><fmt:formatDate
									value="${date}" pattern="E" /></span>
						</button>
					</c:forEach>
				</div>
			</div>
			<div class="quick_resArea">
				<div class="movie_choice">
					<p class="title title-cinema" data-num="${param.movie_num}">영화</p>
					<div class="all-list">
						<ul>
							<c:forEach var="movie" items="${movieList}" varStatus="status">
								<li data-order="${status.index}">
									<button type="button" class="btn" data-num="${movie.movie_num}">
										<c:set var="ratingNumber" value="${fn:substring(movie.m_rating, 0, 2)}" />
										<c:if test="${ratingNumber == '12'}">
											<span class="movie-grade"><img src="${pageContext.request.contextPath}/images/12.png"
												class="ratingicon"></span>
										</c:if>
										<c:if test="${ratingNumber == '15'}">
											<span class="movie-grade"><img src="${pageContext.request.contextPath}/images/15.png"
												class="ratingicon"></span>
										</c:if>
										<c:if test="${ratingNumber == '전체'}">
											<span class="movie-grade"><img src="${pageContext.request.contextPath}/images/ALL.png"
												class="ratingicon"></span>
										</c:if>
										<c:if test="${ratingNumber == '청소'}">
											<span class="movie-grade"><img src="${pageContext.request.contextPath}/images/18.png"
												class="ratingicon"></span>
										</c:if>
										<span class="movie-title">${movie.m_title}</span>
									</button>
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
								<c:if test="${theater.th_num != 101}">
									<li>
										<button type="button" class="btn" id="theater_btn"
											data-num="${theater.th_num}">&nbsp;&nbsp;&nbsp;${theater.th_name}</button>
									</li>
								</c:if>
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

						</ul>
					</div>
				</div>
			</div>
		</div>
	</form>
	<br> <br>
</div>