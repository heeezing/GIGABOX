<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- 구매 내역 시작 -->
<div class="page-main mypage-reservation">
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">구매 내역</h2>
		</div>
	</div>
	<div class="mypage-content">
		<ul>
			<li>구매 내역이 없습니다.</li>
		</ul>
		<c:if test="${count==0}">
		
		</c:if>
		<c:if test="${count>0}">
		<table class="striped-table">
			<tr>
				<th>주문번호</th>
				<th>결제일시</th>
				<th>상품명</th>
				<th>수량</th>
				<th>가격</th>
				<th>주문상태</th>
				<th>취소</th>
			</tr>
		</table>
		</c:if>
	</div>
</div>
<!-- 구매 내역 끝 -->