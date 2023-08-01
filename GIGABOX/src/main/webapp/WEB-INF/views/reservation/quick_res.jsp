<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<form:form modelAttribute="ReservationVO" action="quick_resSel.do" id="quick_res">
		<div class="quick_resContent">
			<div class="dateSelect">
				<div class="august" style="left: 30px; z-index: 1; opacity: 1;">2023.08</div>
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
				</div>
			</div>
			<div class="quick_resArea">
					<div class="movie_choice">
						<p class="title">영화</p>
						<div class="all-list">
							<ul>
								<li>영화제목1</li>
								<li>영화제목2</li>
								<li>영화제목3</li>
								<li>영화제목4</li>
								<li>영화제목5</li>
								<li>영화제목6</li>
								<li>영화제목7</li>
								<li>영화제목8</li>
								<li>영화제목9</li>
								<li>영화제목10</li>
								<li>영화제목11</li>
								<li>영화제목12</li>
								<li>영화제목13</li>
								<li>영화제목14</li>
								<li>영화제목15</li>
							</ul>
						</div>
					</div>
					<div class="theater-choice">
						<div class="title_area">
							<p class="title">극장</p>
						</div>
						<div class="all-list">
							<ul>
								<li>극장1</li>
								<li>극장2</li>
								<li>극장3</li>
								<li>극장4</li>
								<li>극장5</li>
								<li>극장6</li>
								<li>극장7</li>
							</ul>
						</div>
					</div>
					<div class="time-choice">
						<div class="title_area">
							<p class="title">시간</p>
						</div>
						<div class="all-list">
							<ul class="timetable">
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
								<li>
									<div class="sch_left">
										<p class="sch_start">00:00</p>
										<p class="sch_end">~ 00:00</p>
									</div>
									<p class="m_title">영화제목</p>
									<div class="sch_right">
										<span class="hall_name">&nbsp;&nbsp;&nbsp;상영관</span>
										<span class="seat_count">
											<span class="now">50</span>
											<span class="slash">/</span>
											<span class="all">100</span>
										</span>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
		</div>
	</form:form>
	<br>
	<br>
</div>