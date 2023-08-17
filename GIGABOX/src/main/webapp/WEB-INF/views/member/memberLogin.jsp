<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
	.loginmain{padding-left:500px; margin:40px;}
</style>
<!-- 로그인 폼 시작 -->
	<h2 class="loginmain">회원로그인</h2>
	<form:form modelAttribute="memberVO" action="login.do" id="member_login">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li class="floating-label">
				<form:input path="id" placeholder="아이디" cssClass="form-input" autocomplete="off"/>
				<form:label path="id">아이디</form:label>
				<form:errors path="id" element="div" cssClass="error-color"/>
			</li>
			<li class="floating-label">
				<form:password path="passwd" placeholder="비밀번호" cssClass="form-input"/>
				<form:label path="passwd">비밀번호</form:label>
				<form:errors path="passwd" element="div" cssClass="error-color"/>
			</li>
			<li>
				<label for="auto"><input type="checkbox" name="auto" id="auto">로그인상태유지</label>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="login-btn">로그인</form:button>
			<br><br>
			<a href="/member/findpw">비밀번호찾기</a>
			<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=621f753e46e1d4873265bd1481f1a380&redirect_uri=http://localhost:8000/auth/kakao/callback"><img src="/images/kakao_login_button.png"></a>
		</div>
	</form:form>
<!-- 로그인 폼 끝 -->