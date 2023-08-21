<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/review_register.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie.css">
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
						<img
						src="../movie/imageView.do?movie_num=${reservation.movie_num}&movie_type=1">
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
							<td>${reservation.sch_date}${reservation.sch_start}</td>
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
					<input type="button" value="관람평 작성" id="openrwButton">
<%-- 					<!-- 모달 -->
					<div class="rw-modal" id="rw-modal">
						<div class="rw-content">
							<!-- 모달 내용 -->
							<div id="review_div">
								<form id="review_form">
									<input type="hidden" name="movie_num"
										value="${movie.movie_num}" id="movie_num">
									<!-- 관람평 평점 입력 -->
									<h3 class="align-center" style="letter-spacing: 1.8px;">
										<span style="color: #503396; font-size: 20px;">${movie.m_title }</span>의
										평점을 선택해주세요.
									</h3>
									<div class="rating-wrap align-center">
										<fieldset class="rating_score">
											<input type="radio" name="rating_score" value="10"
												id="star10" /><label for="star10" class="full"></label> <input
												type="radio" name="rating_score" value="9" id="star9" /><label
												for="star9" class="half"></label> <input type="radio"
												name="rating_score" value="8" id="star8" /><label
												for="star8" class="full"></label> <input type="radio"
												name="rating_score" value="7" id="star7" /><label
												for="star7" class="half"></label> <input type="radio"
												name="rating_score" value="6" id="star6" /><label
												for="star6" class="full"></label> <input type="radio"
												name="rating_score" value="5" id="star5" /><label
												for="star5" class="half"></label> <input type="radio"
												name="rating_score" value="4" id="star4" /><label
												for="star4" class="full"></label> <input type="radio"
												name="rating_score" value="3" id="star3" /><label
												for="star3" class="half"></label> <input type="radio"
												name="rating_score" value="2" id="star2" /><label
												for="star2" class="full"></label> <input type="radio"
												name="rating_score" value="1" id="star1" /><label
												for="star1" class="half"></label>
										</fieldset>
										<span class="rating-value"
											style="font-size: 40px; font-weight: 1000; color: #000;">0</span>
										<span
											style="font-size: 14px; font-weight: bold; color: #333; margin-top: 25px; margin-left: 10px;">&nbsp;/&nbsp;
											10</span>
									</div>
									<!-- 관람평 평점 입력 끝 -->
									<textarea rows="3" cols="50" name="review_content"
										id="review_content" class="review-content"
										<c:if test="${empty user}">disabled="disabled"</c:if>><c:if
											test="${empty user}"></c:if></textarea>
									<c:if test="${!empty user}">
										<div id="review_first">
											<span class="letter-count align-right">220/220</span>
										</div>
										<div id="review_second" class="align-center">
											<input type="button" value="취소하기" class="review-cancel-btn">
											<input type="button" value="작성하기" id="review-btn">
										</div>
									</c:if>
								</form>
							</div><!--end of review_div -->
						</div><!-- end of reviewwritemodal-content -->
					</div><!-- 모달 끝 --> --%>
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
         <td class="align-center"><fmt:formatNumber value="${reservation.res_total}" type="number" pattern="#,##0"/>원</td>
      </tr>
      </c:if>
      </c:forEach>
   </table>
   <div class="align-center">${pageDel}</div>
</div>
<!-- 예매 내역 끝 -->