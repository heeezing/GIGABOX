<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 멤버십 목록 시작-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/membership.css"> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/membership.js"></script>
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../membership/membership_list.do">멤버십</a> 
	</div>
</div>

<div class="page-main">
	<div class="title" align="center">
		<b>GIGA 멤버십</b>
	</div>
	
	<hr size="2" noshade="noshade">
	
	<!-- 상품 목록 시작 -->
	<c:if test="${count == 0}">
		<div class="result-display">
			표시할 상품이 없습니다.
		</div>
	</c:if>
	
	<c:if test="${count > 0}">
		<div class="membership_list">
			<div class="horizontal-membership-container">
				<c:forEach var="membership" items="${list}">
					<div class="horizontal-membership-item">
						<span class="list-name"><b>${membership.membership_grade}</b></span><br>
						<span class="list-detail">${membership.membership_detail}</span><br>
						<img src="imageView.do?membership_id=${membership.membership_id}"><br>
						<span class="list-benefits">${membership.membership_benefits}</span><br>
						<span class="list-price"> <fmt:formatNumber value="${membership.price}" />원
						</span><br>
						<!-- 여기에 구독 버튼 추가 가능 -->
						<a href="${pageContext.request.contextPath}/membership/msorderForm.do?membership_id=${membership.membership_id}"
							class="subscribe-button">
							<button class="subscribe-btn">구독하기</button>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:if>
</div>

<!-- 멤버십 목록 종료 -->


















