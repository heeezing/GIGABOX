<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 주문 시작 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
		<a href="../cart/list.do">장바구니</a> 
	</div>
</div>
<div class="page-main">
	<!-- 주문 단계 UI 표시 -->
	<div class="cart_step_wrap">
		<ul class="cart_step">
			<li class="step1 active">
				<i class="bi bi-cart3"></i>
				<span style="float:right;"><b>STEP 01<br>장바구니</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step2 ">
				<i class="bi bi-credit-card"></i>
				<span style="float:right;"><b>STEP 02<br>결제하기</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step3">
				<i class="bi bi-check-circle"></i>
				<span style="float:right;"><b>STEP 03<br>결제 완료</b></span>
			</li>
		</ul>
	</div>
	
	<!-- 구매 상품 정보 -->
	<strong class="com_box_design_title">구매상품 정보</strong>
	<form:form modelAttribute="orderVO" action="order.do" id="order_register">
		<table class="cart-table">
			<thead>
			<tr>
				<th>상품명</th>
				<th>판매금액</th>
				<th>수량</th>
				<th>구매금액</th>
			</tr>
			</thead>
			
			<tbody>
			<c:forEach var="cart" items="${list}">
			<tr>
				<!-- (1)상품명 -->
				<td>
					<span class="product-img">
					<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${cart.sn_num}">
					<strong class="product-name">${cart.snackVO.sn_name}</strong>
					<span class="product-detail">${cart.snackVO.sn_detail}</span>
					</span>
				</td>
				<!-- (2)판매금액 -->
				<td class="align-center">
					<!-- 할인가가 있을 경우 -->
					<c:if test="${cart.snackVO.sn_dc_price > 0}">
					<span>
						<fmt:formatNumber value="${cart.snackVO.sn_dc_price}"/>원
					</span><br>
					<span class="origin-price">
						<fmt:formatNumber value="${cart.snackVO.sn_price}"/>원
					</span>
					</c:if>
					<!-- 할인가가 없을 경우 -->
					<c:if test="${cart.snackVO.sn_dc_price == 0 || cart.snackVO.sn_dc_price == ''}">
					<span>
						<fmt:formatNumber value="${cart.snackVO.sn_price}"/>원
					</span>
					</c:if>
				</td>
				<!-- (3)구매수량 -->
				<td class="align-center">
					<fmt:formatNumber value="${cart.orders_quantity}"/>개
				</td>
				<!-- (4)구매금액 --> 
				<td class="align-center">
					<div class="sub-total" data-total="${cart.sub_total}">
						<fmt:formatNumber value="${cart.sub_total}"/>원
					</div>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>

		<!-- 주문자 정보 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">주문자 정보</strong>
	       <ul class="com_box_design">
	           <li>
	               <label for="user_info_name">이름</label>
	               <input type="text" id="user_info_name" style="width: 128px" value="${name}" readonly>
	               
	               <label for="user_info_phonenum">휴대전화 번호</label>
	               <input type="tel" id="user_info_phonenum" style="width: 228px" value="${phone}" readonly>
	           </li>
	       </ul>
	       <p class="com_box_design_olist">
	           * 주문자 정보는 '마이페이지 > 회원정보 수정'에서 가능합니다.
	       </p>
	  	</div>
	  	
		<!-- 결제 수단 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">결제 수단</strong>
	       <ul class="com_box_design">
	           <li>
					<input type="radio" name="payment" value="1" id="payment1" class="com_custom_radio" id="payment_card" checked>신용카드
	           </li>
	           <li>
					<input type="radio" name="payment" value="2" id="payment2" class="com_custom_radio" id="payment_kakao">카카오페이
	           </li>
	       </ul>
	  	</div>
		
		<!-- 포인트 사용 정보 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">포인트</strong>
	       <ul class="com_box_design">
	           <li>
	               <label for="user_info_name">보유</label>
	               <input type="text" id="have_point" style="width: 228px" value="보유포인트" readonly>
	               
	               <label for="user_info_phonenum">사용</label>
	               <input type="number" id="use_point" style="width: 228px" value="사용포인트">
	           </li>
	       </ul>
	       <p class="com_box_design_olist">
	           * 주문자 정보는 '마이페이지 > 회원정보 수정'에서 가능합니다.
	       </p>
	  	</div>
		
		<!-- 금액 합계 -->
		<table class="cart_total_price_wrap">
		   <colgroup>
		        <col style="width:33%">
		        <col style="width:34%">
		        <col style="width:33%">
		   </colgroup>
		    
		   <thead>
		        <tr>
		            <th>총 상품 금액</th>
		            <th>포인트 사용 금액</th>
		            <th>총 결제 예정금액</th>
		        </tr>
		   </thead>
		    
		   <tbody>
		        <tr>
		            <td>
		            	<span class="all-total" data-alltotal="${all_total}">
						<fmt:formatNumber value="${all_total}"/>원
						</span>
		            </td>
		            <td class="cart_calculator_marker">
		            	<span class="use-point">
		            	<fmt:formatNumber value="0"/>원
		            	</span>
		            </td>
		            <td>
		            	<span class="fianl-total" data-finaltotal="" style="color:red;">
						<fmt:formatNumber value=""/>원
						</span>
					</td>
		        </tr>
		    </tbody>
		</table>
		
		<!-- 버튼 -->
		<div class="btn_wrap">
			<a href="#">
				결제하기
			</a>
		</div>
		<!-- 
		<div class="align-center">
			<input type="submit" id="order_btn" value="구매하기">
		</div>
		 -->
	</form:form>
	<!-- 목록 끝 -->
</div>
<!-- 주문 시작 -->