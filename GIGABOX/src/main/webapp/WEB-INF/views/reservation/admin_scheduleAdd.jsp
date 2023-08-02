<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상영시간표 등록 시작 -->
<div class="page-main">
	<h2>상영시간표 등록</h2>
	<form:form modelAttribute="scheduleVO" action="admin_scheduleAdd.do" id="admin_scheduleAdd">
		<ul>
			<li>
				<form:label path="">영화 이름</form:label>
			</li>
			<li>
				<form:label path="">극장</form:label>
			</li>
			<li>
				<form:label path="">상영관</form:label>
			</li>
			<li>
				<form:label path="">상영날짜</form:label>
			</li>
			<li>
				<form:label path="">시작 시간</form:label>
			</li>
			<li>
				<form:label path="">종료 시간</form:label>
			</li>
		</ul>
	</form:form>
</div>