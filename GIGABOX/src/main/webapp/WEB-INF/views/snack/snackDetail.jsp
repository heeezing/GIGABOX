<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 스토어 상세 시작 -->
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
		<a href="../snack/detail.do?sn_num=${snack.sn_num}">스토어 상세</a> 
	</div>
</div>

<div class="page-main">
	<c:if test="${snack.sn_status == 1}">
	<div class="result-display">
		<div class="align-center">
			본 상품은 판매 중지되었습니다.
			<input type="button" value="판매상품 보기" onclick="location.href='list.do'">
		</div>
	</div>
	</c:if>

	<c:if test="${snack.sn_status == 2}">
	<h2 class="align-center">${snack.sn_name}</h2>
	<div class="item-image">
		<img src="imageView.do?sn_num=${snack.sn_num}" width="400" height="400">
	</div>
	<div class="item-detail">
		<form id="item_cart" method="post">
			<input type="hidden" name="sn_num" value="${snack.sn_num}" id="sn_num">
			<input type="hidden" name="sn_price" value="${snack.sn_price}" id="sn_price">
			<ul>
				<li>가격 : <b><fmt:formatNumber value="${snack.sn_price}"/></b></li>
				
				<li>
					<label for="order_quantity">구매수량</label>
					<input type="number" name="order_quantity" min="1" max="${item.quantity}" 
						   id="order_quantity" class="quantity-width">
				</li>
				<li>
					<span id="item_total_txt">총 주문 금액 : 0원</span>
				</li>
			
			
			</ul>
		</form>
	</div>

	</c:if>
</div>
<!-- 스토어 상세 끝 -->