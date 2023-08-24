<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/del_res.js"></script>
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
   <h2>예매 목록</h2>
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
				<input type="button" value="목록" onclick="location.href='admin_resList.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 예매 내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>예매번호</th>
			<th>회원명</th>
			<th>영화제목</th>
			<th>상영일시</th>
			<th>극장/상영관</th>
			<th>가격/인원</th>
			<th>예매상태</th>
			<th></th>
		</tr>
		<c:forEach var="reservation" items="${list}">
		<tr>
			<td class="align-center">${reservation.res_num}</td>
			<td class="align-center">${reservation.name}</td>
			<td class="align-center">${reservation.m_title}</td>
			<td class="align-center">${reservation.sch_date} ${reservation.sch_start}</td>
			<td class="align-center">${reservation.th_name} / ${reservation.hall_name}</td>
			<td class="align-center"><fmt:formatNumber value="${reservation.res_total}" type="number" pattern="#,##0" />원 / ${reservation.res_people}명</td>
			<td class="align-center">
				<c:if test="${reservation.res_status == 2}"><span style="color: red;">취소</span></c:if>
				<c:if test="${reservation.res_status == 1}"><span style="color: blue;">완료</span></c:if>
			</td>
			<td class="align-center">
				<input type="button" value="취소" class="cancel_btn" data-num="${reservation.res_num}">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상영시간표 목록 끝 -->