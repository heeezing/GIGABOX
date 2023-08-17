<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 포인트 내역 시작 -->
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
<div class="page-main">
	<div class="title"><a href="admin_list.do">포인트 내역</a></div>
	<!-- 검색창 -->
	<form action="admin_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" 
					  <c:if test="${param.keyfield == 1}">selected</c:if>>아이디</option>
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

	<!-- 목록 -->
	<c:if test="${count == 0}">
	<div class="result-display">표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>아이디</th>
			<th>내용</th>
			<th>결제금액</th>
			<th>적립</th>
			<th>사용</th>
			<th>등록일</th>
		</tr>
		<c:forEach var="point" items="${list}">
		<tr>
			<td class="align-center">${point.id}</td>
			<td class="align-center">
				<c:if test="${empty point.sn_name && empty point.m_title}">
				가입 축하 포인트
				</c:if>
				<c:if test="${!empty point.sn_name}">
				${point.sn_name}
				</c:if>
				<c:if test="${!empty point.m_title}">
				${point.m_title}
				</c:if>
			</td>
			<td class="align-center"><fmt:formatNumber value="${point.orders_total}"/></td>
			<td class="align-center"><fmt:formatNumber value="${point.add_point}"/></td>
			<td class="align-center"><fmt:formatNumber value="${point.use_point}"/></td>
			<td class="align-center">${point.pt_date}</td>
		</tr>
		</c:forEach>
	</table>
	<!-- 페이지 -->
	<div class="align-center">${page}</div>
	</c:if>
	
</div>
<!-- 포인트 내역  끝 -->
