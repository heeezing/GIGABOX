


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<div class="title">
		추첨 이벤트
	</div>
	<form action="eventAdminList.do" method="get" id="search_form">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"
						<c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2"
						<c:if test="${param.keyfield == 2}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" >
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='eventAdminList.do'">
			</li>
		</ul>
		<input type="button" value="이벤트등록" onclick="location.href='eventWrite.do'">
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">분류</th>
				<th scope="col">이벤트명</th>
				<th scope="col">발표일</th>
				<th scope="col">당첨자발표</th>
			</tr>
			<c:forEach var="event" items="${list}">
		                    <tr>
		                       <td>${event.event_num}</td>
							   <td>${event.category_detail_name}</td>
							   <td><a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}">${event.title}</a></td>
							   <td>${event.event_end}</td>
							   <td>
									<c:if test="${event.state == 1}">
									<button onClick="location.href='eventResultDetail.do?event_num=${event.event_num}'">결과확인</button>
									</c:if>
									<c:if test="${event.state == 0}">
									대기중
									</c:if>
									<c:if test="${event.state == 0 && user.auth == 9 }">
									<button onclick="location.href='eventResultWrite.do?event_num=${event.event_num}'">결과작성</button>
									</c:if>
								</td>
		                    </tr>
	                	</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>