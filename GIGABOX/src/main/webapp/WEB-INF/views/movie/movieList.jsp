<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 영화 목록 시작 -->
<div class="page-main">
	<h2>박스오피스</h2>
	<form>
		<c:if test="${!empty user}"></c:if>
		<input type="button" value="글쓰기" onclick="location.href='insert.do'">
	</form>
</div>
<!-- 영화 목록 끝 -->