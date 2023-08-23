<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- 예매 내역 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		})
	});
</script>
<div class="page-main mypage-reservation">
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">문의 내역</h2>
		</div>
	</div>
	<form action="csList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>문의제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>제목/내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='reviewList.do'"> 
			</li>
		</ul>
		<%-- <div class="aligh-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>리뷰번호</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>작성날짜</option>
			</select>
			<script type="text/javascript">
				$(function(){
					$('#order').change(function(){
						location.href='reviewList.do?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
					});
				})
			</script>  
		</div> --%>
	</form>
	<c:if test="${count == 0}">
	<div class="tit-util mt70">
		<div class="mypage-content">
			<ul>
				<li>문의내역이 없습니다.</li>
			</ul>
		</div>
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>문의번호</th>
			<th>제목</th>
			<th>문의내용</th>
			<th>답변여부</th>
		</tr>
		<c:forEach var="cs" items="${list}">
		<tr>
			<td class="align-center">${cs.personal_num}</td>
			<td class="align-center">${cs.title}</td>
			<td class="align-center">${cs.content}</td>
			<td class="cs">
				<c:if test="${cs.state == 1}">답변완료</c:if>
				<c:if test="${cs.state == 0}">답변대기</c:if>
			</td>
			
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 예매 내역 끝 -->