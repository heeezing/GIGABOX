<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상영시간표 등록 시작 -->
<div class="page-main">
	<h2>상영시간표 등록</h2>
	<form:form modelAttribute="scheduleVO" action="admin_scheduleAdd.do" id="admin_scheduleAdd">
		<ul>
			<li>
				<form:label path="movie_name">영화 제목</form:label>
				<form:input path="movie_name"/>
				<form:errors path="movie_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="theater_name">극장</form:label>
				<form:input path="theater_name"/>
				<form:errors path="theater_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="hall_name">상영관</form:label>
				<form:input path="hall_name"/>
				<form:errors path="hall_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="sch_date">상영날짜</form:label>
				<form:input path="sch_date" id="datepicker"/>
				<form:errors path="sch_date" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="sch_start">시작 시간</form:label>
				<form:input path="sch_start"/>
				<form:errors path="sch_start" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="sch_end">종료 시간</form:label>
				<form:input path="sch_end"/>
				<form:errors path="sch_end" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>전송</form:button>
			<input type="button" value="목록" onclick="location.href='admin_schedule.do'">
		</div>
	</form:form>
</div>