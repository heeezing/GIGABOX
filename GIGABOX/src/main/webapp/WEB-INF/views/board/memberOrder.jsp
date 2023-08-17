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
			<h2 class="tit">주문 내역</h2>
		</div>
	</div>
	<form action="orderList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>주문번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>주문날짜</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='orderList.do'"> 
			</li>
		</ul>
		<div class="aligh-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>주문번호</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>주문날짜</option>
			</select>
			<script type="text/javascript">
				$(function(){
					$('#order').change(function(){
						location.href='orderList.do?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
					});
				})
			</script>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="tit-util mt70">
		<div class="mypage-content">
			<ul>
				<li>예매 내역이 없습니다.</li>
			</ul>
		</div>
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>주문번호</th>
			<th>주문날짜</th>
			<th>상품이름</th>
			<th>총금액</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">${order.orders_num}</td>
			<td class="align-center">${order.orders_date}</td>
			<td class="align-center">${order.sn_name}</td>
			<td class="align-center">${order.orders_total}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 예매 내역 끝 -->