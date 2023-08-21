<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<!-- 예매 내역 시작 -->
<div class="page-main mypage-reservation">
   <div class="tit-util mt70">
      <div>
         <h2 class="tit">예매 내역</h2>
      </div>
   </div>
   <c:if test="${count == 0}">
   <div class="mypage-content">
      <ul>
         <li>예매 내역이 없습니다.</li>
      </ul>
   </div>
   </c:if>
   <c:if test="${count > 0}">
   <c:forEach var="reservation" items="${list}">
   <c:if test="${reservation.res_status == 1}">
   <div class="res-box">
      <a href="/movie/movieDetail.do?movie_num=' + item.movie_num + '">
         <img src="../movie/imageView.do?movie_num=${reservation.movie_num}&movie_type=1">
      </a>
		<table class="res-table">
			<tr>
				<th>예매번호</th>
				<td colspan="3" class="res-num-text">${reservation.res_num}</td>
			</tr>
			<tr>
				<th>영화명</th>
				<td colspan="3">${reservation.m_title}</td>
			</tr>
			<tr>
				<th>극장/상영관</th>
				<td>${reservation.th_name}/${reservation.hall_name}</td>
				<th>관람인원</th>
				<td>${reservation.res_people}명</td>
			</tr>
			<tr>
				<th>관람일시</th>
				<td>${reservation.sch_date} ${reservation.sch_start}</td>
				<th>관람좌석</th>
				<td>${reservation.res_seats}</td>
			</tr>
		</table>
		<div class="bg-ground">
			<table class="res-table">
				<tr>
					<th>결제일</th>
					<td>${reservation.res_date}</td>
				</tr>
			</table>
		</div>
		<input type="button" value="예매취소" class="del-res">
   </div>
   </c:if>
   </c:forEach>
   </c:if>
   <%-- 페이지처리 개수 수정해야함!! page가 두개라 나눠야할듯???!?!?!? --%>
   <div class="align-center">${page}</div>
   <div class="tit-util mt70">
      <div>
         <h2 class="tit">예매 취소 내역</h2>
      </div>
   </div>
   <table class="striped-table">
      <tr>
         <th>취소일시</th>
         <th>영화명</th>
         <th>극장</th>
         <th>상영일시</th>
         <th>취소금액</th>
      </tr>
      <c:forEach var="reservation" items="${list}">
      <c:if test="${reservation.res_status == 2}">
      <tr>
         <td class="align-center">${reservation.del_date}</td>
         <td class="align-center">${reservation.m_title}</td>
         <td class="align-center">${reservation.th_name}</td>
         <td class="align-center">${reservation.res_date}</td>
         <td class="align-center">${reservation.res_total}</td>
      </tr>
      </c:if>
      </c:forEach>
   </table>
   <div class="align-center">${pageDel}</div>
</div>
<!-- 예매 내역 끝 -->