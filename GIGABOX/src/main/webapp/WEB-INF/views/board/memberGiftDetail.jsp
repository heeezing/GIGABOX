<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 선물 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/store.orderDetail.js"></script>
<div class="page-main mypage-reservation">
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">선물 상세</h2>
		</div>
	</div>
	<div class="status-change">
		<dl>
			<dt>전송일</dt>
			<dd class="border-right margin">${orders_date}</dd>
			<dt>주문번호</dt>
			<dd class="border-right margin" id="orders_num">${orders.orders_num}</dd>
			<dt>사용현황</dt>
			<dd class="margin">
				<c:if test="${orders.orders_status == 1}">사용가능</c:if>
				<c:if test="${orders.orders_status == 2}">${modify_date} 사용완료</c:if>
				<c:if test="${orders.orders_status == 3}">기간만료</c:if>
				<c:if test="${orders.orders_status == 4}">${modify_date} 주문취소</c:if>
			</dd>
	 	</dl>
	</div>
		
	<!-- 선물 정보 -->
	<c:if test="${orders.orders_type == 2}">
	<div class="com_box_design_title payment-info">선물 정보</div>
	<div class="gift-wrap">
		<div class="gift-to"><b>TO.</b> ${orders.to_id}</div>
		<div class="gift-msg">${orders.message}</div>
		<div class="gift-from"><b>FROM.</b> ${orders.from_id}</div>
		<div class="gift-hr"></div>
	</div>
	</c:if>
	
	<!-- 구매 상품 정보 -->
	<strong class="com_box_design_title" style="margin-left:0;">상품 정보</strong>	
		<table class="cart-table" style="margin-bottom:65px;">
			<thead style="background-color: #f8f8f8;">
			<tr>
				<th>상품명</th>
				<th>수량</th>
			</tr>
			</thead>
			
			<tbody>
				<c:forEach var="detail" items="${detail}">
				<tr>
					<!-- (1)상품명 -->
					<td>
						<span class="product-img" style="padding:0 20px;">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${detail.sn_num}">
						<strong class="product-name">${detail.sn_name}</strong>
						<span class="product-detail">${detail.sn_detail}</span>
						</span>
					</td>
					<!-- (2)구매수량 -->
					<td class="align-center" style="padding:0 20px;">
						<span style="padding:0 20px;">
						<fmt:formatNumber value="${detail.orders_quantity}"/>개
						</span>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
	<div class="btn_wrap">
		<a href="giftList.do">목록</a> 
	</div>
</div>
<!-- 선물 상세 끝 -->


