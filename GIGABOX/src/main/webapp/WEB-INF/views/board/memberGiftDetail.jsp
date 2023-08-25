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
			<dt>유효기간</dt>
			<dd class="margin">
				${orders.orders_date} ~ ${orders.valid_date}
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
				<th style="width:100px;">쿠폰번호</th>
				<th>상품명</th>
				<th>수량</th>
				<th>상태</th>
			</tr>
			</thead>
			
			<tbody>
				<c:forEach var="detail" items="${detail}">
				<tr>
					<!-- (1)쿠폰번호 -->
					<td class="align-center">${detail.detail_num}</td>
					<!-- (2)상품명 -->
					<td>
						<span class="product-img" style="padding:0 20px;">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${detail.sn_num}">
						<strong class="product-name">${detail.sn_name}</strong>
						<span class="product-detail">${detail.sn_detail}</span>
						</span>
					</td>
					<!-- (3)구매수량 -->
					<td class="align-center" style="padding:0 20px;">
						<span style="padding:0 20px;">
						<fmt:formatNumber value="${detail.orders_quantity}"/>개
						</span>
					</td>
					<!-- (4)상태 -->
					<td class="align-center status-span">
						<c:if test="${detail.orders_status == 1}"><span style="color:blue;">사용가능</span></c:if>
						<c:if test="${detail.orders_status == 2}">
						<span style="color:green;">사용완료</span><br>
						<span style="font-size:9pt;">
							<fmt:formatDate value="${detail.modify_date}" pattern="yy-MM-dd HH:mm:ss"/>
						</span>
						</c:if>
						<c:if test="${detail.orders_status == 3}"><span style="color:gray;">기간만료</span></c:if>
						<c:if test="${detail.orders_status == 4}">
						<span style="color:red;">주문취소</span><br>
						<span style="font-size:9pt;">
							<fmt:formatDate value="${detail.modify_date}" pattern="yy-MM-dd HH:mm:ss"/>
						</span>
						</c:if>
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


