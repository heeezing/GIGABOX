<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<!-- 포인트 내역 시작 -->
<div class="page-main mypage-reservation">
	<div class="my-point">
		<span style="font-size:16pt;">나의 GIGA 포인트 : </span>
		<span style="font-size:22pt;"><fmt:formatNumber value="${totalPoint}"/>원</span>
		<p>${user.nick_name}님은 ${membership} 등급으로, 결제 시 금액의 ${pointRate}가 적립됩니다.</p>
	</div>
	
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">포인트 내역</h2>
		</div>
	</div>

	<!-- 목록 -->
	<c:if test="${count == 0}">
	<div class="result-display">표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>거래일</th>
			<th>내용</th>
			<th>상품금액</th>
			<th>적립</th>
			<th>사용</th>
		</tr>
		<c:forEach var="point" items="${list}">
		<tr>
			<td class="align-center">${point.pt_date}</td>
			<td class="align-center">${point.pt_detail}</td>
			<td class="align-center">
				<c:if test="${point.orders_total != 0}">
				<fmt:formatNumber value="${point.orders_total}"/>원
				</c:if>
				<c:if test="${point.res_total != 0}">
				<fmt:formatNumber value="${point.res_total}"/>원
				</c:if>
			</td>
			<td class="align-center"><fmt:formatNumber value="${point.add_point}"/>P</td>
			<td class="align-center"><fmt:formatNumber value="${point.use_point}"/>P</td>
		</tr>
		</c:forEach>
	</table>
	<!-- 페이지 -->
	<div class="align-center">${page}</div>
	</c:if>
	
</div>
<!-- 포인트 내역  끝 -->
