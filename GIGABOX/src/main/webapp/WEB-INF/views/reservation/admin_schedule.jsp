<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상영시간표 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
   <h2>상영시간표 목록</h2>
   <form action="admin_schedule.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>영화제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>극장</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상영관</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>상영날짜</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='admin_schedule.do'">
			</li>
		</ul>
		<div class="align-right">
			<c:if test="${!empty user}">
				<input type="button" value="글쓰기" onclick="location.href='admin_scheduleAdd.do'">
			</c:if>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>상영번호</th>
			<th>영화제목</th>
			<th>극장/상영관</th>
			<th>상영날짜</th>
			<th>상영시간</th>
		</tr>
		<c:forEach var="schedule" items="${list}">
		<tr>
			<td class="align-center">${schedule.sch_num}</td>
			<td width="400">${schedule.m_title}</td>
			<td class="align-center">${schedule.th_name} / ${schedule.hall_name}</td>
			<td class="align-center">${schedule.sch_date}</td>
			<td class="align-center">${schedule.sch_start} ~ ${schedule.sch_end}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상영시간표 목록 끝 -->