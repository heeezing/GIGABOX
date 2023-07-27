<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 헤더 시작 -->
<div class="page-main">
	<!-- 상단 -->
	<div id="top_left">
		<ul>
			<li><a href="#">고객센터</a></li>
			<li><a href="#">빠른예매</a></li>
		</ul>
	</div>
	<div id="top_right">
		<!-- 1. 로그아웃 상태인 경우 -->
		<ul>
			<c:if test="${empty user}">
			<li><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
			<li><a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a></li>
			</c:if>
		</ul>
		 
		<!-- 2. 로그인 상태인 경우 -->
		<c:if test="${!empty user}">
		<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
			<c:if test="${user.auth == 2}"> <!-- 일반 회원 -->
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
			</c:if>
			<c:if test="${user.auth == 9}"> <!-- 관리자 -->
			<a href="${pageContext.request.contextPath}/main/admin.do">관리자 메인</a>
			</c:if>
		</c:if>
	</div>

	<!-- 메뉴 -->
	<div id="main_nav">
		<ul>
			<li class="outer-menu-item">
				<a href="#">영화</a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="#">박스오피스</a></li>
					<li class="inner-menu-item"><a href="#">상영예정작</a></li>
					<li class="inner-menu-item"><a href="#">무비포스트</a></li>
				</ul>
			</li>
			<li class="outer-menu-item">
				<a href="#">극장</a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="#">빠른예매</a></li>
					<li class="inner-menu-item"><a href="#">상영시간표</a></li>
				</ul>
			</li>
			<li>
				<a href="#">예매</a>
			</li>
			<li id="logo">
				<a href="${pageContext.request.contextPath}/main/main.do">
					<img src="${pageContext.request.contextPath}/images/logo.png" width="160">
				</a>
			</li>
			<li class="outer-menu-item">
				<a href="#">이벤트</a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="#">진행중이벤트</a></li>
					<li class="inner-menu-item"><a href="#">지난이벤트</a></li>
					<li class="inner-menu-item"><a href="#">당첨자발표</a></li>
				</ul>
			</li>
			<li>
				<a href="#">스토어</a>
			</li>
			<li>
				<a href="#">멤버십</a>
			</li>
		</ul>
	</div>
</div><br><br>
<hr size="1" width="100%">
<!-- 헤더 끝 -->
