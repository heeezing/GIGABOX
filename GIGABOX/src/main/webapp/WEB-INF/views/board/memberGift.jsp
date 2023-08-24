<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- 선물 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main mypage-reservation">
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">내 선물함</h2>
		</div>
	</div>
	<!-- 검색창 시작 -->
	<form action="giftList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" 
					 <c:if test="${param.keyfield==1}">selected</c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="조회">
			</li>
		</ul>
	</form> 
	<!-- 검색창 끝 -->
	<!-- 목록 시작 -->
	<c:if test="${count == 0}">
		<div class="result-display">표시할 선물 정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>주문번호</th>
			<th>상품명</th>
			<th>보내신분</th>
			<th>선물수신일</th>
			<th>유효기간</th>
		</tr>
		<c:forEach var="gift" items="${list}">
		<tr>
			<td class="align-center">
				<a href="giftDetail.do?orders_num=${gift.orders_num}">${gift.orders_num}</a>
			</td>
			<td class="align-center">
				<a href="giftDetail.do?orders_num=${gift.orders_num}">${gift.sn_name}</a>
			</td>
			<td class="align-center">${gift.from_id}</td>
			<td class="align-center">${gift.orders_date}</td>
			<td class="align-center">~${gift.valid_date}</td>
		</tr>
		</c:forEach>
	</table>
	<!-- 페이지 처리 -->
	<div class="align-center">${page}</div>
	</c:if>
	<!-- 목록 끝 -->
</div>
<!-- 선물 목록 끝 -->