<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<b>멤버십 등급 : ${membership}</b><br>
			<b>포인트 : ${point}P</b><br>
			<a href="${pageContext.request.contextPath}/board/pointList.do">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포인트 내역></a>
		</div>
	</div>
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">나의 예매 내역</h2>
			<a href='${pageContext.request.contextPath}/board/reservationList.do'>더보기></a>
		</div>
	</div>
	<div class="mypage-content">
		<c:if test="${empty rList}">
		<div class="">
			<div class="">
				<ul>
					<li>예매 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		</c:if>
		<c:if test="${!empty rList}">
		<table class="striped-table">
			<tr>
				<th>예매번호</th>
				<th>예매날짜</th>
				<th>인원</th>
				<th>결제방법</th>
				<th>총 가격</th>
			</tr>
			<c:forEach var="reservation" items="${rList}">
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
		<c:if test="${empty oList}">
		<div class="">
			<div class="">
				<ul>
					<li>주문 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		</c:if>
		<c:if test="${!empty oList}">
		<table class="striped-table">
			<tr>
				<th>주문일</th>
				<th>주문번호</th>
				<th>상품명</th>
				<th>구매금액</th>
				<th>내역</th>
			</tr>
			<c:forEach var="order" items="${oList}">
			<tr>
				<td class="align-center">${order.orders_date}</td>
				<td class="align-center">
					<a href="../board/orderDetail.do?orders_num=${order.orders_num}">${order.orders_num}</a>
				</td>
				<td class="align-center">
					<a href="../board/orderDetail.do?orders_num=${order.orders_num}">${order.sn_name}</a>
				</td>
				<td class="align-center"><fmt:formatNumber value="${order.orders_total}"/>원</td>
				<td class="align-center">
					<c:if test="${order.orders_type == 1}">구매</c:if>
					<c:if test="${order.orders_type == 2}">선물</c:if>
				</td>
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
			<c:if test="${empty eList}">
			<div class="tit-util mt70">
				<div class="mypage-content">
					<ul>
						<li>응모내역이 없습니다.</li>
					</ul>
				</div>
			</div>
			</c:if>
			<c:if test="${!empty eList}">
			<table class="striped-table">
				<tr>
					<th>번호</th>
					<th>이벤트 제목</th>
					<th>결과</th>
				</tr>
				<c:forEach var="event" items="${eList}">
				<tr>
					<td class="align-center">${event.rnum}</td>
					<td class="align-center" style="max-width: 12em; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${event.title}</td>
					<td class="align-center">
					<a href="${pageContext.request.contextPath}/event/eventResultDetail.do?event_num=${event.event_num}">
					<input type="button"value="결과확인">
					</a>
					</td>			
				</tr>
				</c:forEach>
			</table>
			</c:if>
		</div>
		<div class="mypage-right">
			<div class="tit-util">
				<h2 class="tit">문의 내역</h2>
				<a href="${pageContext.request.contextPath}/board/csList.do">더보기></a>
			</div>
			<c:if test="${empty cList}">
			<div class="tit-util mt70">
				<div class="mypage-content">
					<ul>
						<li>문의내역이 없습니다.</li>
					</ul>
				</div>
			</div>
			</c:if>
			<c:if test="${!empty cList}">
			<table class="striped-table">
				<tr>
					<th>문의번호</th>
					<th>제목</th>
					<th>문의내용</th>
					<th>답변여부</th>
				</tr>
				<c:forEach var="cs" items="${cList}">
				<tr>
					<td class="align-center">${cs.personal_num}</td>
					<td class="align-center" style="max-width: 5em; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${cs.title}</td>
					<td class="align-center"style="max-width: 5em; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${cs.content}</td>
					<td class="cs">
						<c:if test="${cs.state == 1}"><b style="color:blue">답변완료</b></c:if>
						<c:if test="${cs.state == 0}">답변대기</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
			</c:if>
		</div>
	</div>
</div>
<!-- myPage 끝 -->