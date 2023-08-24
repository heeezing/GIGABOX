<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상영관 목록 시작 -->
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
		
		// 삭제
		$('.delete_btn').click(function(){
			let choice = confirm('삭제하시겠습니까?');
			if(choice){
				location.replace('hallDelete.do?hall_num='+$(this).attr('data-num'));
				alert('삭제가 완료되었습니다')
			}
		});
	});
</script>
<div class="page-main">
	<div class="title">
		상영관목록
	</div>
	<form action="hallList.do" method="get" id="search_form">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"
						<c:if test="${param.keyfield == 1}">selected</c:if>>상영관명</option>
					<option value="2"
						<c:if test="${param.keyfield == 2}">selected</c:if>>극장명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='hallList.do'">
			</li>
		</ul>
		<div class="align-right">
			<input type="button" value="상영관등록" onclick="location.href='hallAdd.do'">
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>상영관명</th>
			<th>극장명</th>
			<th>좌석수</th>
			<th>상영 가능 여부</th>
			<th>수정</th>
		</tr>
		<c:forEach var="hall" items="${list}">
		<tr>
			<td class="align-center">${hall.hall_num}</td>
			<td class="align-center">${hall.hall_name}</td>
			<td class="align-center">${hall.th_name}</td>
			<td class="align-center">${hall.seats}</td>
			<td class="align-center">
				<c:if test="${hall.hall_status==1}">상영 불가능</c:if>
				<c:if test="${hall.hall_status==2}">상영 가능</c:if>
			</td>
			<td class="align-center">
				<input type="button" value="수정" onclick="location.href='hallUpdate.do?hall_num=${hall.hall_num}'">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>