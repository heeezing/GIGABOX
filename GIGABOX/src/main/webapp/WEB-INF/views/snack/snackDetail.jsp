<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 스토어 상세 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/snack-detail.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/snack.css">
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
	<div class="item-wrap">
		<div class="item-image">
			<img src="imageView.do?sn_num=${snack.sn_num}" width="400" height="400">
		</div>
		<div class="item-detail">
			<form id="item_cart" method="post"> 
				<input type="hidden" name="sn_num" value="${snack.sn_num}" id="sn_num">
				<input type="hidden" name="sn_detail" value="${snack.sn_detail}" id="sn_detail">
				<input type="hidden" name="sn_price" value="${snack.sn_price}" id="sn_price">
				<input type="hidden" name="sn_dc_price" value="${snack.sn_dc_price}" id="sn_dc_price">
				<div class="cart-info">
					<ul>
						<li class="sn-name">
							${snack.sn_name}
							<c:if test="${user.auth == 9}">
							<input type="button" value="수정" style="float:right;"
							onclick="location.href='${pageContext.request.contextPath}/snack/admin_update.do?sn_num=${snack.sn_num}'">
							</c:if>
						</li>
						<li>
							<span class="cart-info-span">가격</span>
							<!-- 할인가가 있을 경우 -->
							<c:if test="${snack.sn_dc_price > 0}">
							<span class="list-price-red" style="width:80px;">
							<b><fmt:formatNumber value="${snack.sn_dc_price}"/>원</b>
							</span>
							<span class="list-dc-price">
							<fmt:formatNumber value="${snack.sn_price}"/>원
							</span>
							</c:if>
							<!-- 할인가가 없을 경우 -->
							<c:if test="${snack.sn_dc_price == 0 || snack.sn_dc_price == ''}">
							<span class="list-price">
							<b><fmt:formatNumber value="${snack.sn_price}"/>원</b>
							</span>
							</c:if>
						</li>
						<li>
							<span class="cart-info-span">구성</span>${snack.sn_detail}
						</li>
						<li>
							<span class="cart-info-span">유효기간</span>구매일로부터 1년
						</li>
						<li>
							<span class="cart-info-span">구매제한</span>1회 최대 10개 구매 가능
						</li>
					</ul>
				</div>
				<!-- 주문 수량 버튼 -->
				<div class="bx_num">
					<button class="btn_mins">삭제</button>
					<div id="txt_num">
						<input type="number" name="orders_quantity" value="1" min="1" max="10" 
						  	   id="orders_quantity" readonly>
					</div>
					<button class="btn_plus">추가</button>
				</div>
				<!-- 총 구매 금액 -->
				<div class="txt_price_wrap">
					총 구매 금액
					<strong class="txt_price_str">
					<c:if test="${snack.sn_dc_price > 0}">
					<fmt:formatNumber value="${snack.sn_dc_price}"/>
					</c:if>
					<c:if test="${snack.sn_dc_price == 0 || snack.sn_dc_price == ''}">
					<fmt:formatNumber value="${snack.sn_price}"/>
					</c:if>
					</strong>
					원
				</div>
				<!-- 장바구니,선물,구매 버튼 -->
				<div class="btn_wrap">
					<input type="submit" value="" class="btn_cart">
					<a href="${pageContext.request.contextPath}/order/orderForm.do" id="btn_gift">
						선물하기
					</a>
					<a href="#" id="btn_order">
						구매하기
					</a>
				</div>
			</form>
		</div>
	</div>
	
	<hr size="2" noshade width="100%" color="#000">
	
	<div class="category_product_detail_txtbox">
		${snack.sn_info}
	</div>
	
	<div class="category_product_notice_txtbox">
		${snack.sn_notice}
	</div>
	
	</c:if>
</div>
<!-- 스토어 상세 끝 -->