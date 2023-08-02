<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 헤더 시작 -->
<div class="page-main">
	<!-- 상단 -->
	<div id="top_left">
		<ul>
			<li><a href="#">고객센터</a></li>
			<li><a href="${pageContext.request.contextPath}/reservation/quick_res.do">빠른예매</a></li>
		</ul>
	</div>
	<div id="top_right">
		<ul>
			<li>
				<c:if test="${!empty user && user.auth == 2}"><!-- 일반 회원 -->
					<a href="${pageContext.request.contextPath}/member/myPage.do">My페이지</a>
				</c:if>
			</li>
			<li>
				<c:if test="${!empty user && !empty user.nick_name}">
					[<span class="user_name">${user.nick_name}</span>]<!-- 별명이 있으면 별명 표시 -->
				</c:if>
				<c:if test="${!empty user && empty user.nick_name}">
					[<span class="user_name">${user.id}</span>]<!-- 별명이 없으면 id표시 -->
				</c:if>
			</li>
			<li>
				<c:if test="${!empty user}">
					<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
				</c:if>
			</li>
				
			<li>
				<c:if test="${empty user}"><!-- user 식별자가 없으면(user가 비어있으면) -->
					<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
					<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
				</c:if>
			</li>
			<li>
				<c:if test="${empty user || user.auth <9}">
					<a href="${pageContext.request.contextPath}/main/main.do">홈으로</a>
				</c:if>
			</li>
			<li>
				<c:if test="${!empty user && user.auth == 9}">
					<a href="${pageContext.request.contextPath}/main/admin.do">관리자 메인</a>
				</c:if>
			</li>
		</ul>
		<!-- 1. 로그아웃 상태인 경우 
		<ul>
			<c:if test="${empty user}">
			<li><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
			<li><a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a></li>
			</c:if>
		</ul>
		 -->
		 
		<!-- 2. 로그인 상태인 경우
		<ul>
			<c:if test="${!empty user}">
			<li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
			<c:if test="${user.auth == 2}">
			<li><a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a></li>
			</c:if>
			<c:if test="${user.auth == 9}">
			<li><a href="${pageContext.request.contextPath}/main/admin.do">관리자 메인</a></li>
			</c:if>
			</c:if>
		</ul> 
		 -->
	</div>

	<!-- 메뉴 -->
	<div id="main_nav">
		<ul>
			<li class="outer-menu-item">
				<a href="#"><b>영화</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/movie/movieList.do">박스오피스</a></li>
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/movie/premovieList.do">상영예정작</a></li>
					<li class="inner-menu-item"><a href="#">무비포스트</a></li>
				</ul>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/theater/theaterDetail.do"><b>극장</b></a>
			</li>
			<li class="outer-menu-item">
				<a href="${pageContext.request.contextPath}/reservation/quick_res.do"><b>예매</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/reservation/quick_res.do">빠른예매</a></li>
					<li class="inner-menu-item"><a href="#">상영시간표</a></li>
				</ul>
			</li>
			<li id="logo">
				<a href="${pageContext.request.contextPath}/main/main.do">
					<img src="${pageContext.request.contextPath}/images/logo.png" width="160">
				</a>
			</li>
			<li class="outer-menu-item">
				<a href="#"><b>이벤트</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="#">진행중이벤트</a></li>
					<li class="inner-menu-item"><a href="#">지난이벤트</a></li>
					<li class="inner-menu-item"><a href="#">당첨자발표</a></li>
				</ul>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/snack/list.do"><b>스토어</b></a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/membership/membershipList.do"><b>멤버십</b></a>
			</li>
		</ul>
	</div>
</div><br><br>
<hr size="1" width="100%">
<!-- 헤더 끝 -->
