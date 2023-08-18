<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../reservation/quick_res.do">예매</a> 
		<a>예매완료</a>
	</div>
</div>
<div class="page-main">
	<div class="title" style="color: #503396!important; font-weight: bold;">
		예매완료
	</div>
	<div class="reserve-info-box">
		<div class="movie-poster-area">
			<img src="../image_bundle/no_image.jpg">
		</div>
		<div class="movie-info-area">
			<div class="movie-info-top">
				<strong>예매가 완료되었습니다 !</strong>
				<span>
					<i class="icon"></i>
					고객님의 적립 포인트는 <em>700P</em>입니다.
				</span>
			</div>
			<div class="movie-info-middle">
				<ul>
					<li>
						<span>예매영화</span>${scheduleVO.m_title}
					</li>
					<li>
						<span>관람극장/상영관</span>${scheduleVO.th_name} / ${scheduleVO.hall_name}
					</li>
					<li>
						<span>관람일시</span>${scheduleVO.sch_date} ${scheduleVO.sch_start}
					</li>
					<li>
						<span>관람인원</span>1명
					</li>
					<li>
						<span>좌석번호</span>A1
					</li>
					<li>
						<span>전화번호</span>010-1234-5678
					</li>
					<li>
						<span>결제정보</span><strong>12,000</strong> 원
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="myRes-btn"> 
		<input type="button" value="예매내역" onclick="location.href='../board/reservationList.do'">
	</div>
	<div class="notice-box">
		<ul class="notice-cont-tit">
			<li>상영안내</li>
			<ul class="notice-cont">
				<li>- 쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
				<li>- 지연입장에 의한 관람불편을 최소화하고자 본 영화는 10분 후 시작됩니다.</li>
				<li>- 상영시간 20분전까지 취소 가능하며, 캡쳐화면으로는 입장하실 수 없습니다.</li>
			</ul>
			<li>주차안내</li>
			<ul class="notice-cont">
				<li>- 매표소에 당일 영화 티켓 인증 후, 차량 번호 할인 등록.</li>
				<li>- 주차 공간이 협소하므로 가급적이면 대중교통을 이용 바랍니다.</li>
			</ul>
		</ul>
	</div>
</div>