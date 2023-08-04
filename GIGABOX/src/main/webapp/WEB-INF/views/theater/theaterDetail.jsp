<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/theater.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/theaterDetail.js"></script>
<div class="page-util">
   <div class="location">
      <span>홈</span> 
      <a>극장</a>
   </div>
</div>
<div class="page-main">
	<!-- 극장 선택 목록 시작 -->
	<div class="theater-choice-area">
		<div class="choice-main">
			<b><span>원하는 극장 선택</span></b>
		</div>
		<div class="theater-list-section">
			<ul>
				<c:forEach var="theater" items="${list}">
				<li>
					<button class="th-name" data-num="${theater.th_num}">${theater.th_name}</button>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!-- 극장 선택 목록 끝 -->
	
	<!-- 극장 정보 시작 -->
	<div class="wrap-theater">
		<h3>
			<img src="${pageContext.request.contextPath}/images/h3_theater.gif">
		</h3>
		<h1 class="info-title">강남</h1>
		<div class="wrap-theaterinfo">
			<div class="box-image">
				<img src="${pageContext.request.contextPath}/images/강남.jpg">
			</div>
			<div class="box-contents">
				<h1 class="theater-name">
					강남
				</h1>
				<div class="box-text">
					<div><span class="theater-address"><b>서울특별시 강남구 강남대로 438 (역삼동)</b></span></div>
					<br>
					<div><span class="theater-info">1544-1122<br>6관 / 874석</span></div>
				</div>
			</div>
		</div>
	</div>
	<!-- 극장 정보 끝 -->
</div>