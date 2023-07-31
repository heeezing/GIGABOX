<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 등록</title>
</head>
<body>
<div class="page-main">
	<h2>멤버십 등록</h2>
	<form:form modelAttribute="membershipVO" action="registerMembership.do" id="membership_register">
		<ul>
			<li>
				<form:label path="grade">등급</form:label>
				<form:input path="grade"/>
			</li>
			<li>
				<form:label path="detail">혜택</form:label>
				<form:input path="detail"/>
			</li>
			<li>
				<form:label path="price">가격</form:label>
				<form:input path="price"/>
			</li>
		</ul>
	</form:form>
</div>
</body>
</html>