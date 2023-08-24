<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
	</div>
</div>
<div class="page-main">
	<!-- 주문 단계 UI 표시 -->
	<div class="cart_step_wrap">
		<ul class="cart_step">
			<li class="step1">
				<i class="bi bi-cart3"></i>
				<span style="float:right;"><b>STEP 01<br>장바구니</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step2">
				<i class="bi bi-pencil-square"></i>
				<span style="float:right;"><b>STEP 02<br>주문 정보</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step3 ">
				<i class="bi bi-credit-card"></i>
				<span style="float:right;"><b>STEP 03<br>결제하기</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step4 active">
				<i class="bi bi-check-circle"></i>
				<span style="float:right;"><b>STEP 04<br>결제 완료</b></span>
			</li>
		</ul>
	</div>
	
	<ul style="border-bottom:1px solid #000; padding:0;">
		<li class="no_data">
			<img src="${pageContext.request.contextPath}/images/orderComplete.png" width="50">
			<p style="font-size:20pt; margin:14px auto;">결제가 완료되었습니다.</p>
			<p style="font-size:10pt; margin-bottom::14px; color:gray;">주문 번호 : ${orders_num}</p>
			<p style="font-size:14pt;">주문 내역은 마이페이지에서 확인 가능합니다.</p>
			<div class="btn_wrap" style="margin-top:60px;">
				<a href="${pageContext.request.contextPath}/snack/list.do">스토어 홈</a>
				<a href="${pageContext.request.contextPath}/board/orderList.do">마이페이지</a>
			</div>
		</li>
	</ul>
	
	<span>* 주문 번호를 꼭 지참하시어 직원에게 보여주셔야 사용 가능합니다.</span><br>
	<span>* 포인트 사용 결제 시 부분 취소가 불가합니다.</span>

</div>