<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- 구매 내역 시작 -->
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
			<h2 class="tit">구매 내역</h2>
		</div>
	</div>
	<!-- 검색창 시작 -->
	<form action="orderList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" 
					 <c:if test="${param.keyfield==1}">selected</c:if>>주문번호</option>
					<option value="2" 
					 <c:if test="${param.keyfield==2}">selected</c:if>>상품명</option>
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
		<div class="result-display">표시할 구매 정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>구매일</th>
			<th>주문번호</th>
			<th>상품명</th>
			<th>구매금액</th>
			<th>내역</th>
			<th>상태</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">${order.orders_date}</td>
			<td class="align-center">
				<a href="orderDetail.do?orders_num=${order.orders_num}">${order.orders_num}</a>
			</td>
			<td class="align-center">
				<a href="orderDetail.do?orders_num=${order.orders_num}">${order.sn_name}</a>
			</td>
			<td class="align-center"><fmt:formatNumber value="${order.orders_total}"/>원</td>
			<td class="align-center">
				<c:if test="${order.orders_type == 1}">구매</c:if>
				<c:if test="${order.orders_type == 2}">선물</c:if>
			</td>
			<td class="align-center">
				<c:if test="${order.orders_status == 1}"><span style="color:blue;">사용가능</span></c:if>
				<c:if test="${order.orders_status == 2}"><span style="color:green;">사용완료</span></c:if>
				<c:if test="${order.orders_status == 3}"><span style="color:gray;">기간만료</span></c:if>
				<c:if test="${order.orders_status == 4}"><span style="color:red;">주문취소</span></c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<!-- 페이지 처리 -->
	<div class="align-center">${page}</div>
	</c:if>
	<!-- 목록 끝 -->
</div>
<!-- 구매 내역 끝 -->