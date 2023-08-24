<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/review_register.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/del_res.js"></script>
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
		<div class="res-box">
			<a href="/movie/movieDetail.do?movie_num= ${reservation.movie_num}">
				<c:if test="${!empty reservation.m_poster}"><img src="../movie/imageView.do?movie_num=${reservation.movie_num}&movie_type=1"></c:if>
				<c:if test="${empty reservation.m_poster}"><img src="${reservation.m_poster2}" alt="${reservation.m_title}"></c:if>
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
					<td>${reservation.sch_date} &nbsp;${reservation.sch_start}</td>
					<th>관람좌석</th>
					<td>${reservation.res_seats}</td>
				</tr>
			</table>
			<div class="bg-ground">
				<table class="res-table">
					<tr>
						<th>결제일</th>
						<td>${reservation.res_date}</td>
						<th>총 결제금액</th>
						<td><fmt:formatNumber value="${reservation.res_total}" type="number" pattern="#,##0"/>원</td>
					</tr>
				</table>
			</div>
			<c:if test="${now_date == reservation.sch_date && now_time < reservation.sch_start}">
			<input type="button" value="예매취소" class="del-res" data-num="${reservation.res_num}"> 
			</c:if>
			<c:if test="${now_date < reservation.sch_date}">
			<input type="button" value="예매취소" class="del-res" data-num="${reservation.res_num}"> 
			</c:if>
			<c:if test="${now_date == reservation.sch_date && now_time > reservation.sch_start}">
			<input type="button" value="관람평 작성" class="del-res2" id="openrwButton">
			</c:if>
			<c:if test="${now_date > reservation.sch_date}">
			<input type="button" value="관람평 작성" class="del-res2" id="openrwButton">
			</c:if>
					<!-- 모달 -->
					<div class="rw-modal" id="rw-modal">
						<div class="rw-content">
							<!-- 모달 내용 -->
							<div id="review_div">
								<form id="review_form2">
									<input type="hidden" name="movie_num"
										value="${reservation.movie_num}" id="movie_num">
									<!-- 관람평 평점 입력 -->
									<h3 class="align-center" style="letter-spacing: 1.8px;">
										<span style="color: #503396; font-size: 20px;">${reservation.m_title}</span>의
										평점을 선택해주세요.
									</h3>
									<div class="rating-wrap align-center">
										<fieldset class="rating_score">
											<input type="radio" name="rating_score" value="10" id="10" /><label
												for="10" class="full"></label> <input type="radio"
												name="rating_score" value="9" id="9" /><label for="9"
												class="half"></label> <input type="radio"
												name="rating_score" value="8" id="8" /><label for="8"
												class="full"></label> <input type="radio"
												name="rating_score" value="7" id="7" /><label for="7"
												class="half"></label> <input type="radio"
												name="rating_score" value="6" id="6" /><label for="6"
												class="full"></label> <input type="radio"
												name="rating_score" value="5" id="5" /><label for="5"
												class="half"></label> <input type="radio"
												name="rating_score" value="4" id="4" /><label for="4"
												class="full"></label> <input type="radio"
												name="rating_score" value="3" id="3" /><label for="3"
												class="half"></label> <input type="radio"
												name="rating_score" value="2" id="2" /><label for="2"
												class="full"></label> <input type="radio"
												name="rating_score" value="1" id="1" /><label for="1"
												class="half"></label>
										</fieldset>
										<span class="rating-value"
											style="font-size: 40px; font-weight: 1000; color: #000;">0</span>
										<span
											style="font-size: 14px; font-weight: bold; color: #333; margin-top: 25px; margin-left: 10px;">&nbsp;/&nbsp;
											10</span>
									</div>
									<!-- 관람평 평점 입력 끝 -->
									<textarea rows="3" cols="50" name="review_content"
										id="review_content2" class="review-content"
										style="border: 1px solid rgb(118, 118, 118);"
										<c:if test="${empty user}">disabled="disabled"</c:if>><c:if
											test="${empty user}"></c:if></textarea>
									<c:if test="${!empty user}">
										<div id="review_first2">
											<span class="letter-count align-right">220/220</span>
										</div>
										<div id="review_second2" class="align-center">
												<input type="button" value="취소하기" class="review-cancel-btn">
											<input type="submit" value="작성하기" id="review-btn2">
										</div>
									</c:if>
								</form>
							</div>
							<!--end of review_div -->
						</div>
						<!-- end of reviewwritemodal-content -->
					</div>
					<!-- 모달 끝 -->
				</div>
   </c:forEach>
   </c:if>
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
      <c:forEach var="delReservation" items="${DelList}">
      <tr>
         <td class="align-center">${delReservation.del_date}</td>
         <td class="align-center">${delReservation.m_title}</td>
         <td class="align-center">${delReservation.th_name}</td>
         <td class="align-center">${delReservation.res_date}</td>
         <td class="align-center"><fmt:formatNumber value="${delReservation.res_total}" type="number" pattern="#,##0"/>원</td>
      </tr>
      </c:forEach>
   </table>
   <div class="align-center">${pageDel}</div>
</div>
<!-- 예매 내역 끝 -->