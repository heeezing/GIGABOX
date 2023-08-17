<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 장바구니 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/store.cart.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
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
	
	<!-- 목록 시작 -->
	<c:if test="${empty list}">
	<ul style="border-bottom:1px solid #000;">
		<li class="no_data">
			<img src="${pageContext.request.contextPath}/images/no_result.png" width="50">
			<p>장바구니에 담긴 상품이 없습니다.<br>스토어에서 상품을 확인해보세요!</p>
			<a href="${pageContext.request.contextPath}/snack/list.do" class="go-store">쇼핑 계속하기</a>
		</li>
	</ul>
	</c:if>
	
	<c:if test="${!empty list}">
	<form id="cart_order" method="post" name="cart_order" 
		  action="${pageContext.request.contextPath}/order/orderForm.do">
	<input type="hidden" name="orders_type" value="1" id="orders_type">
		<table class="cart-table">
			<thead>
			<tr>
				<th><input type="checkbox" checked="checked" id="chk_all"></th>
				<th>상품명</th>
				<th>판매금액</th>
				<th>수량</th>
				<th>구매금액</th>
			</tr>
			</thead>
			
			<tbody>
			<c:forEach var="cart" items="${list}">
			<tr>
				<!-- (1)체크박스 -->
				<td class="align-center">
					<input type="checkbox" name="cart_numbers" checked="checked" 
						   class="choice-btn" value="${cart.cart_num}">
				</td>
				<!-- (2)상품명 -->
				<td>
					<a href="${pageContext.request.contextPath}/snack/detail.do?sn_num=${cart.sn_num}" class="product-img">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${cart.sn_num}">
						<strong class="product-name">${cart.snackVO.sn_name}</strong>
						<span class="product-detail">${cart.snackVO.sn_detail}</span>
					</a>
				</td>
				<!-- (3)판매금액 -->
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
				<!-- (4)구매수량 -->
				<td class="align-center" style="margin:0 auto;">
					<div class="orders-quantity">
						<c:if test="${cart.snackVO.sn_status == 1}">[판매중지]</c:if>
						<c:if test="${cart.snackVO.sn_status == 2}">
						<div class="count-wrap">
						    <button type="button" class="minus">-</button>
						    <input type="number" name="orders_quantity" min="1" max="10" autocomplete="off" value="${cart.orders_quantity}" class="inp" readonly/>
						    <button type="button" class="plus">+</button>
						</div>
						<input type="button" value="변경" class="cart-modify" 
							   data-cartnum="${cart.cart_num}" data-snnum="${cart.sn_num}">
							   
						</c:if>
					</div>
				</td>
				<!-- (5)구매금액 --> 
				<td class="align-center">
					<div class="sub-total" data-total="${cart.sub_total}">
						<fmt:formatNumber value="${cart.sub_total}"/>원
						<input type="hidden" value=""  name="real_total" data-realtotal="${cart.sub_real_total}">
						<input type="button" value="삭제" class="cart-del" data-cartnum="${cart.cart_num}">
					</div>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<input type="button" value="선택삭제" id="selectDelete_btn">
		<span id="info_span">* 장바구니에는 최대 10개의 상품만 담을 수 있습니다.</span>		
		
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
		            <th>할인금액</th>
		            <th>총 결제 예정금액</th>
		        </tr>
		   </thead>
		    
		   <tbody>
		        <tr>
		            <td>
		            	<span class="origin-total" data-origintotal="${origin_total}">
		            	<fmt:formatNumber value="${origin_total}"/>원
		            	</span>
		            </td>
		            <td class="cart_calculator_marker">
		            	<span class="dc-total" data-dctotal="${dc_total}">
		            	<fmt:formatNumber value="${dc_total}"/>원
		            	</span>
		            </td>
		            <td>
		            	<span class="all-total" data-alltotal="${all_total}" style="color:red;">
						<fmt:formatNumber value="${all_total}"/>원
						</span>
					</td>
		        </tr>
		    </tbody>
		</table>
		
		<!-- 버튼 -->
		<div class="btn_wrap">
			<a href="#" id="cart_gift">선물하기</a>
			<a href="javascript:void(0);" onclick="document.forms['cart_order'].submit();">구매하기</a>
		</div>
		<!-- 
		<div class="align-center">
			<input type="submit" id="order_btn" value="구매하기">
		</div>
		 -->
	</form>
	</c:if>
	<!-- 목록 끝 -->
</div>
<!-- 장바구니 끝 -->