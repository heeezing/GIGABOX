<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 수정</title>
</head>
<body>
<div class="page-main">
	<h2>멤버십 수정</h2>
	<form:form modelAttribute="membershipVO" action="membership_update.do" id="modify_form">
		<form:hidden path="membership_id"/>
		<ul>
			<li>
				<form:label path="membership_grade">등급</form:label>
				<form:input path="membership_grade"/>
			</li>
			<li>
				<form:label path="membership_detail">혜택</form:label>
				<form:input path="membership_detail"/>
			</li>
			<li>
				<form:label path="price">가격</form:label>
				<form:input path="price"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>수정</form:button>
			<input type="button" value="목록" onclick="location.href='membership_list.do'">
		</div>
	</form:form>
</div>
</body>
</html>