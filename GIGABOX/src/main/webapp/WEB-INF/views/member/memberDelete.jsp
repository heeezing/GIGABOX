<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 회원탈퇴 폼 시작 -->
	<h2>회원탈퇴</h2>
	<form:form modelAttribute="memberVO" action="delete.do" id="member_delete">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="id">아이디</form:label>
				<form:input path="id"/>
				<form:errors path="id" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="passwd">비밀번호</form:label>
				<form:password path="passwd"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="MY페이지" onclick="location.href='myPage.do'" class="default-btn">
		</div>
	</form:form>
<!-- 회원탈퇴 폼 끝 -->