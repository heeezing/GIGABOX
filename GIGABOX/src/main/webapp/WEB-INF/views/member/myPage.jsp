<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- myPage 시작 -->
<div class="mypage">
	<div class="mypage-top">
		<div class="mypage-photo"><img src="${pageContext.request.contextPath}/member/photoView.do" width="100" height="100" class="my-photo"></div>
		<div class="mypage-hi">
			안녕하세요 !
			<p>${member.name}<span>님</span></p>
		</div>

		<div class="mypage-point">
			<b>포인트 : 0P</b><br>
			<a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포인트 내역></a>
		</div>
	</div>
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">나의 예매 내역</h2>
			<a href='${pageContext.request.contextPath}/board/reservationList.do'>더보기></a>
		</div>
	</div>
	<div class="mypage-content">
		<c:if test="${count1 == 0}">
		<div class="">
			<div class="">
				<ul>
					<li>예매 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		</c:if>
		<c:if test="${count1 > 0}">
		<table class="striped-table">
			<tr>
				<th>예매번호</th>
				<th>예매날짜</th>
				<th>사람수</th>
				<th>가격</th>
				<th>총 가격</th>
			</tr>
			<c:forEach var="reservation" items="${list1}">
			<tr>
				<td class="align-center">${reservation.res_num}</td>
				<td class="align-center">${reservation.res_date}</td>
				<td class="align-center">${reservation.res_people}</td>
				<td class="align-center">${reservation.res_payment}</td>
				<td class="align-center">${reservation.res_total}</td>
			</tr>
			</c:forEach>
		</table>
		</c:if>
	</div>
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">나의 구매 내역</h2>
			<a href="${pageContext.request.contextPath}/board/orderList.do">더보기></a>
		</div>
	</div>
	<div class="mypage-content">
		<c:if test="${count2 == 0}">
		<div class="">
			<div class="">
				<ul>
					<li>주문 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		</c:if>
		<c:if test="${count2 > 0}">
		<table class="striped-table">
			<tr>
				<th>주문번호</th>
				<th>주문날짜</th>
				<th>상품이름</th>
				<th>가격</th>
				<th>개수</th>
			</tr>
			<c:forEach var="order" items="${list2}">
			<tr>
				<td class="align-center">${order.orders_num}</td>
				<td class="align-center">${order.orders_date}</td>
				<td class="align-center">${order.sn_name}</td>
				<td class="align-center">${order.sn_price}</td>
				<td class="align-center">${order.orders_quantity}</td>
			</tr>
			</c:forEach>
		</table>
		</c:if>
	</div>
	<div class="tit-util mt70">
		<div class="mypage-left">
			<div class="tit-util">
				<h2 class="tit">참여 이벤트</h2>
				<a href="${pageContext.request.contextPath}/board/memberEvent.do">더보기></a>
			</div>
			<div class="mypage-content">
				<ul>
					<li>참여 이벤트 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		<div class="mypage-right">
			<div class="tit-util">
				<h2 class="tit">문의 내역</h2>
				<a href="${pageContext.request.contextPath}/board/memberQuestion.do">더보기></a>
			</div>
			<div class="mypage-content">
				<ul>
					<li>문의 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- myPage 끝 -->