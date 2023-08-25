<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/res_pay.js"></script>
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
		예매결제
	</div>
	<div class="seat-select-section">
		<form id="reservation" action="${pageContext.request.contextPath}/reservation/reservation.do" method="post" name="reservation">
			<input type="hidden" id="res_num" name="res_num" value="${res_num}"/>
			<input type="hidden" name="remain" value="${scheduleVO.remain - reservationVO.res_people}"/>
			<input type="hidden" name="sch_num" value="${scheduleVO.sch_num}"/>
			<div class="seat-section">
				<div class="title-util">
					<h3>포인트</h3>
					<div class="discout-setting">
						<p>보유</p><p class="own_point" id="have_point" data-havePoint="${have_point}"><fmt:formatNumber value="${have_point}"/> point</p>
						<br>
						<p class="use">사용</p><p class="use_point"><input type="number" name="use_point" value="0" class="use-point" id="use_point"> point</p><p class="notice"></p>
						<a class="order_point_input_btn order_point_input_btn_N" data-state="N">전액사용</a>
				  		<a class="order_point_input_btn order_point_input_btn_Y" data-state="Y">사용취소</a>
					</div>
					<h3 class="payment-method">결제수단선택</h3>
					<div class="payment">
						<input type="radio" id="res_payment" name="res_payment" value="카드결제" checked> <p>카드결제 / 간편결제</p>
					</div>
				</div>
			</div>
			<div class="seat-result">
				<div class="wrap">
					<div class="tit-area" style="border:none;">
						<p class="tit" id="m_title">${scheduleVO.m_title}</p>
						<p class="theater">${scheduleVO.th_name}/${scheduleVO.hall_name}</p>
						<p class="date">${scheduleVO.sch_date}  |  ${scheduleVO.sch_start} ~ ${scheduleVO.sch_end}</p>
					</div>
					<div class="price-process">
						<div class="box">
							<div class="data">
								<input type="hidden" name="res_people" value="${reservationVO.res_people}">
								<span class="title">인원 ${reservationVO.res_people}</span>
								<input type="hidden" name="res_seats" value="${reservationVO.res_seats}">
								<span class="title">(${reservationVO.res_seats})</span>
							</div>
							<div class="all">
								<span class="title">금액</span>
								<span class="price">
									<em class="all-total" data-alltotal="${reservationVO.res_people*12000}"><fmt:formatNumber value="${reservationVO.res_people*12000}" type="number" pattern="#,##0"/></em> 원
								</span>
							</div>
						</div>
						<div class="box discout-box">
							<div class="all">
								<span class="title">포인트 사용</span>
								<span class="price"><em class="use-point" >0</em> point</span>
							</div>
						</div>
					</div>
					<div class="pay-area">
						<div class="pay">
							<p class="title">최종결제금액</p>
							<div class="money">
								<input type="hidden" id="res_total" name="res_total" value="${reservationVO.res_people*12000}">
								<em class="final-total"><fmt:formatNumber value="${reservationVO.res_people*12000}" type="number" pattern="#,##0"/></em> <span>원</span>
							</div>
						</div>
					</div>
					<div class="btn-group">
						<input type="button" value="이전" id="btn_booking_back" onclick="goBack()">
						<script>
							function goBack() {
								window.history.back();
							}
						</script>
						<input type="button" value="결제" id="btn_booking_pay">
					</div>
				</div>
			</div>
		</form>
	</div>
	<br>
	<br>
</div>