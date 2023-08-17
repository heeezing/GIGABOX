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
			<li class="step4">
				<i class="bi bi-check-circle"></i>
				<span style="float:right;"><b>STEP 04<br>결제 완료</b></span>
			</li>
		</ul>
	</div>
	
	<ul style="border-bottom:1px solid #000; padding:0;">
		<li class="no_data">
			<img src="${pageContext.request.contextPath}/images/orderFail.png" width="50">
			<p style="font-size:20pt; margin:14px auto; color:red;">결제가 실패되었습니다.</p>
			<p style="font-size:14pt;">결제 중 오류가 발생했습니다. 확인 후 다시 주문 부탁드립니다.</p>
			<div class="btn_wrap" style="margin-top:60px;">
				<a href="${pageContext.request.contextPath}/snack/list.do">스토어 홈</a>
				<a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a>
			</div>
		</li>
	</ul>

</div>