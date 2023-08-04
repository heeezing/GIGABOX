<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hall.js"></script>
<!-- 상영관 등록 시작 -->
<div class="page-main">
	<div class="title">
		상영관등록
	</div>
	<form action="hallAdd.do" id="hall_add" method="post">
		<ul>
			<li>
				<label for="hall_name">상영관명</label>
				<input type="text" name="hall_name" id="hall_name" maxlength="50" width="200">
			</li>
			<li>
				<label for="th_num">극장</label>
				<select name="th_num" id="th_num">
					<option value="0" selected>극장을 선택하세요</option>
					<c:forEach items="${TheaterList}" var="theater">
						<option value="${theater.th_num}" name="${theater.th_num}">${theater.th_name}</option>
					</c:forEach>
				</select>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록" class="button">
			<input type="button" value="목록" class="dafault-btn" onclick="location.href='${pageContext.request.contextPath}/hall/hallList.do'">
		</div>
	</form>
</div>
<!-- 상영관 등록 끝 -->