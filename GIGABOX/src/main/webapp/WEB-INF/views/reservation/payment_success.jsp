<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../reservation/quick_res.do">예매</a> 
		<a>예매완료</a>
	</div>
</div>
<div class="page-main">
	<div class="title" style="color: #503396!important; font-weight: bold;">
		예매완료
	</div>
	<div class="reserve-info-box">
		<div class="movie-poster-area">
			<img src="../image_bundle/no_image.jpg">
		</div>
		<div class="movie-info-area">
			<div class="movie-info-top">
			
			</div>
			<div class="movie-info-middle">
			
			</div>
			<div class="movie-info-bottom">
			
			</div>
		</div>
	</div>
	<br>
	<br>
</div>