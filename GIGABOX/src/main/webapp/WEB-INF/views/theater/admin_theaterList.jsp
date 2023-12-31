<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 극장 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>극장목록</h2>
	<form action="theaterList.do" method="get" id="search_form">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"
						<c:if test="${param.keyfield == 1}">selected</c:if>>극장명</option>
					<option value="2"
						<c:if test="${param.keyfield == 2}">selected</c:if>>주소</option>
					<option value="3"
						<c:if test="${param.keyfield == 3}">selected</c:if>>전화번호</option>
			</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색" class="sub-button">
				<input type="button" value="목록" onclick="location.href='theaterList.do'">
			</li>
		</ul>
		<div class="align-right">
			<input type="button" value="극장등록" onclick="location.href='theaterAdd.do'">
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>극장명</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>수정</th>
		</tr>
		<c:forEach var="theater" items="${list}">
		<tr>
			<td class="align-center">${theater.th_num}</td>
			<td class="align-center">${theater.th_name}</td>
			<td class="align-center">${theater.th_address}</td>
			<td class="align-center">${theater.th_phone}</td>
			<td class="align-center">
				<input type="button" value="수정" onclick="location.href='theaterUpdate.do?th_num=${theater.th_num}'">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>