<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
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
	<div class="seat-select-section">
			<input type="hidden" name="sch_num" value="${scheduleVO.sch_num}"/>
			<div class="seat-section">
				<div class="title-util">
					<h3>포인트</h3>
					<div class="discout-setting">
						<p>보유</p><p class="own_point">0 원</p>
						<br>
						<p class="use">사용</p><p class="use_point"><input type="number" value="0"> 원</p><p class="notice">(1,000원 단위로 사용 가능)</p>
					</div>
					<h3 class="payment-method">결제수단선택</h3>
					<div class="payment">
						<input type="radio"> <p>카드결제 / 간편결제</p>
					</div>
				</div>
			</div>
			<div class="seat-result">
				<div class="wrap">
					<div class="tit-area" style="border:none;">
						<p class="tit">영화제목</p>
						<p class="theater">극장/상영관</p>
						<p class="date">YYYY.MM.DD(D) | 시작시간~종료시간</p>
					</div>
					<div class="price-process">
						<div class="box">
							<div class="data">
								<span class="title">인원 1</span>
								<span class="price">12,000</span>
							</div>
							<div class="all">
								<span class="title">금액</span>
								<span class="price"><em>12,000</em> 원</span>
							</div>
						</div>
						<div class="box discout-box">
							<div class="all">
								<span class="title">할인적용</span>
								<span class="price"><em>0</em> 원</span>
							</div>
						</div>
					</div>
					<div class="pay-area">
						<div class="pay">
							<p class="title">최종결제금액</p>
							<div class="money">
								<em>12,000</em> <span>원</span>
							</div>
						</div>
					</div>
					<div class="btn-group">
						<input type="button" value="이전" id="btn_booking_back">
						<input type="button" value="결제" id="btn_booking_pay">
					</div>
				</div>
			</div>
	</div>
	<br>
	<br>
</div>