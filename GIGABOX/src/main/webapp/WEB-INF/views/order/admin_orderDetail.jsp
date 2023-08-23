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
			<dd class="border-right margin">${orders_date}</dd>
			<dt>주문번호</dt>
			<dd class="border-right margin" id="orders_num">${orders.orders_num}</dd>
			<dt>유효기간</dt>
			<dd class="margin">
				${orders.orders_date} ~ ${orders.valid_date}
			</dd>
	 	</dl>
	</div>
	
	<!-- 구매 상품 정보 -->
	<strong class="com_box_design_title" style="margin-left:0;">구매상품 정보</strong>	
	
		<table class="cart-table" style="margin-bottom:65px;">
			<thead style="background-color: #f8f8f8;">
			<tr>
				<th>쿠폰번호</th>
				<th>상품명</th>
				<th>판매금액</th>
				<th>구매금액</th>
				<th>상태</th>
			</tr>
			</thead>
			
			<tbody>
				<c:forEach var="detail" items="${detail}">
				<tr>
					<!-- (1)쿠폰번호 -->
					<td class="align-center" style="width:150px;" class="detail_num">${detail.detail_num}</td>
					<!-- (2)상품명 -->
					<td>
						<span class="product-img">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${detail.sn_num}">
						<strong class="product-name">${detail.sn_name}</strong>
						<span class="product-detail">${detail.sn_detail}</span>
						</span>
					</td>
					<!-- (3)판매금액 -->
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
					<!-- (4)구매금액 --> 
					<td class="align-center">
						<fmt:formatNumber value="${orders.orders_total}"/>원
					</td>
					<!-- (5)사용상태 -->
					<td class="align-center">
						<c:if test="${detail.orders_status == 1}">
							<span style="color:blue;">사용가능</span><br>
							<div class="button-container">
							<input type="button" value="사용처리" class="round inblue" 
								   data-status="2"  data-num="${detail.detail_num}" onclick="statusChange(this)">
							<input type="button" value="주문취소" class="round inred" 
								   data-status="4"  data-num="${detail.detail_num}" onclick="statusChange(this)">
							</div>						
						</c:if>
						<c:if test="${detail.orders_status == 2}">
						<span style="color:green;">사용완료</span><br>
						<span style="font-size:10pt;">
							<fmt:formatDate value="${detail.modify_date}" pattern="yy-MM-dd HH:mm:ss"/>
						</span>
						</c:if>
						<c:if test="${detail.orders_status == 3}"><span style="color:gray;">기간만료</span></c:if>
						<c:if test="${detail.orders_status == 4}">
						<span style="color:red;">주문취소</span><br>
						<span style="font-size:10pt;">
							<fmt:formatDate value="${detail.modify_date}" pattern="yy-MM-dd HH:mm:ss"/>
						</span>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
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
	
	<!-- 결제 정보 -->
	<div class="com_box_design_title payment-info">결제 정보</div>	
	<table class="cart-table payment-table">
		<tr>
			<td>총 상품 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.origin_total}"/>원</td>
		</tr>
		<tr>
			<td>할인 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.origin_total - orders.orders_total}"/>원</td>
		</tr>
		<tr style="border-bottom:2px solid #dbdbdb;">
			<td>사용 포인트</td>
			<td class="payment-price"><fmt:formatNumber value="${point.use_point}"/>원</td>
		</tr>
		<tr style="height:60px;color:red;">
			<td>총 결제 금액</td>
			<td class="payment-price"><fmt:formatNumber value="${orders.pay_total}"/>원</td>
		</tr>
	</table>
	
	<div class="btn_wrap">
		<a href="admin_list.do">목록</a> 
	</div>
</div>
<!-- 주문 상세 끝 -->


