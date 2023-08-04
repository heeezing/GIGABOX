<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hall.js"></script>
<!-- 상영관 수정 시작 -->
<div class="page-main">
	<div class="title">
		상영관수정
	</div>
	<form action="hallUpdate.do" id="hall_update" method="post">
		<input type="hidden" name="hall_num" value="${hallVO.hall_num}"/>
		<ul>
			<li>
				<label for="hall_name">상영관명</label>
				<input type="text" name="hall_name" id="hall_name" value="${hallVO.hall_name}" maxlength="50" width="200">
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
			<li>
				<label for="hall_status">상영 가능 여부</label>
				<span><input type="radio" name="hall_status" id="hall_status" value="2"
				<c:if test="${hallVO.hall_status==2}">checked</c:if>>가능</span>
				<span><input type="radio" name="hall_status" id="hall_status" value="1"
				<c:if test="${hallVO.hall_status==1}">checked</c:if>>불가능</span>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="수정" class="button">
			<input type="button" value="목록" class="dafault-btn" onclick="location.href='${pageContext.request.contextPath}/hall/hallList.do'">
		</div>
	</form>
</div>
<!-- 상영관 수정 끝 -->