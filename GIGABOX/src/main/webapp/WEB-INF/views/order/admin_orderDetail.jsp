<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 주문 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/store.orderDetail.js"></script>
<div class="page-main">
	<div class="title"><a href="admin_detail.do">주문 상세</a></div>
	<div class="status-change">
		<dl>
			<dt>구매일</dt>
			<dd class="border-right margin">${orders.orders_date}</dd>
			<dt>주문번호</dt>
			<dd class="border-right margin" id="orders_num">${orders.orders_num}</dd>
			<dt>사용현황</dt>
			<dd class="margin">
				<c:if test="${orders.orders_status == 1}">미사용</c:if>
				<c:if test="${orders.orders_status == 2}">사용완료</c:if>
				<c:if test="${orders.orders_status == 3}">기간만료</c:if>
				<c:if test="${orders.orders_status == 4}">주문취소</c:if>
			</dd>
	 	</dl>
	 	<c:if test="${orders.orders_status == 1}">
	 	<input type="button" value="주문취소" class="round inred" id="status_cancel">
		<input type="button" value="사용처리" class="round inblue" id="status_use">
		</c:if>
	</div>
	
	<!-- 구매 상품 정보 -->
	<strong class="com_box_design_title" style="margin-left:0;">구매상품 정보</strong>	
	
		<table class="cart-table" style="margin-bottom:40px;">
			<thead style="background-color: #f8f8f8;">
			<tr>
				<th>상품명</th>
				<th>판매금액</th>
				<th>수량</th>
				<th>구매금액</th>
			</tr>
			</thead>
			
			<tbody>
				<c:forEach var="detail" items="${detail}">
				<tr>
					<!-- (1)상품명 -->
					<td>
						<span class="product-img">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${detail.sn_num}">
						<strong class="product-name">${detail.sn_name}</strong>
						<span class="product-detail">${detail.sn_detail}</span>
						</span>
					</td>
					<!-- (2)판매금액 -->
					<td class="align-center">
						<!-- 할인가가 있을 경우 -->
						<c:if test="${detail.sn_dc_price > 0}">
						<span>
							<fmt:formatNumber value="${detail.sn_dc_price}"/>원
						</span><br>
						<span class="origin-price">
							<fmt:formatNumber value="${detail.sn_price}"/>원
						</span>
						</c:if>
						<!-- 할인가가 없을 경우 -->
						<c:if test="${detail.sn_dc_price == 0 || detail.sn_dc_price == ''}">
						<span>
							<fmt:formatNumber value="${detail.sn_price}"/>원
						</span>
						</c:if>
					</td>
					<!-- (3)구매수량 -->
					<td class="align-center">
						<fmt:formatNumber value="${detail.orders_quantity}"/>개
					</td>
					<!-- (4)구매금액 --> 
					<td class="align-center">
						<fmt:formatNumber value="${orders.orders_total}"/>원
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
	<div class="com_box_design_title payment-info">결제 정보</div>	
	<table class="cart-table payment-table">
		<tr>
			<td>총 상품 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.orders_total}"/>원</td>
		</tr>
		<tr>
			<td>할인 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.origin_total - orders.orders_total}"/>원</td>
		</tr>
		<tr style="border-bottom:2px solid #dbdbdb;">
			<td>사용 포인트</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.use_point}"/>원</td>
		</tr>
		<tr style="height:60px;color:red;">
			<td>총 결제 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.pay_total}"/>원</td>
		</tr>
	</table>
	
	
</div>
<!-- 주문 상세 끝 -->


