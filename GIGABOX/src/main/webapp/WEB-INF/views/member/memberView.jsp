<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- my페이지 시작 -->
<div class="page-main">
	<h2>회원상세정보 <input type="button" value="회원정보수정" onclick="location.href='update.do'"></h2>
	<ul>
		<li>이름 : ${member.name}</li>
		<li>별명 : ${member.nick_name}</li>
		<li>전화번호 : ${member.phone}</li>
		<li>이메일 : ${member.email}</li>
		<li>우편번호 : ${member.zipcode}</li>
		<li>주소 : ${member.address1} ${member.address2}</li>
		<li>가입일 : ${member.reg_date}</li>
	</ul>
		<ul>
		<li>
			<input type="button" class="menu-btn" value="비밀번호변경"
			  onclick="location.href='${pageContext.request.contextPath}/member/changePassword.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="회원탈퇴"
			  onclick="location.href='${pageContext.request.contextPath}/member/delete.do'">
		</li>
	</ul>
</div>
<!-- my페이지 끝 -->