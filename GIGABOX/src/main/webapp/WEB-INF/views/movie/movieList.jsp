<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/movie.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<!-- 영화 목록 시작 -->

<script type="text/javascript">
	$(function() {
		//검색 유효성 체크
		$('#search_form').submit(function() {
			if ($('#keyword').val().trim() == '') {
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>박스오피스</h2>
	<form action="movieList.do" id="search_form" class="list-search" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화감독</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화배우</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기"> 
				<input type="button" value="목록" onclick="location.href='movieList.do'">
			</li>
		</ul>
			<%-- <c:if test="${!empty user}"></c:if>
			<input type="button" value="글쓰기"onclick="location.href='movieRegister.do'"> --%>
		</div>
	</form>
	<c:if test="${count == 0}">
		<div class="result-display">표시할 영화가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<div class="movie-list-parent">
			<c:forEach var="movie" items="${movies}">
				<div class="movie-list">
					<div class="card">
						<a href="movieDetail.do?movie_num=${movie.movie_num}">
							<img src="imageView.do?movie_num=${movie.movie_num}&movie_type=1" class="card-img-top">
						</a>
						<div class="card-body h-100">
							<div class="card-body-title">
								<c:if test="${movie.m_rating =='12세이상관람가'}">
									<span>${movie.m_rating}</span>
									<!-- 나중에 이미지 넣어야해 -->
								</c:if>
								<c:if test="${movie.m_rating == '15세이상관람가'}">
									<span>${movie.m_rating}</span>
								</c:if>
								<c:if test="${movie.m_rating == '청소년관람불가'}">
									<span>${movie.m_rating}</span>
								</c:if>
								<c:if test="${movie.m_rating == '전체관람가'}">
									<span>${movie.m_rating}</span>
								</c:if>

								<h5 class="card-title">
									<a href="movieDetail.do?movie_num=${movie.movie_num}"><b>${movie.m_title}</b></a>
								</h5>
							</div>

							<span class="card-text">개봉일 : ${movie.m_opendate}</span><br>

							<c:if test="${movie.m_status==1}">
								<button type="button" class="btn btn-outline-secondary">예매</button>
							</c:if>
							<c:if test="${movie.m_status!=1}">
								<button type="button" class="btn btn-outline-secondary" disabled>상영종료</button>
							</c:if>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="page-button align-center">${page}</div>
	</c:if>
</div>
<!-- 영화 목록 끝 -->
