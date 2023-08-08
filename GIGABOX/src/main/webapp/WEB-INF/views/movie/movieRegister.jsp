<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 영화 등록 폼 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/movie_register.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie.css">
<div class="page-main">
	<div class="title"><a href="movieRegister.do">영화 등록</a></div>
	<form:form modelAttribute="movieVO" action="movieRegister.do" id="register_form" encType="multipart/form-data">
	<form:errors element="div" cssClass="error-color"/>
		<!--[왼쪽] 사진 미리 보기 -->
		<div id="m_poster">
			<img src="${pageContext.request.contextPath}/images/no_image.jpg" width="300" class="m-poster">
		</div>
		<!--[오른쪽] 상품 정보 입력 -->
		<div id="movie_input">
			<ul>
				<li>
					<label>상영 여부</label>
					<input type="radio" name="m_status" value="1" id="status1" checked>상영
					<input type="radio" name="m_status" value="2" id="status2">상영중지
				</li>
				<li>
					<label for="m_title">영화제목</label>
					<input type="text" name="m_title" id="m_title" maxlength="30" class="form-input">
				</li>
				<li>
					<label for="m_titleEng">영문제목</label>
					<input type="text" name="m_titleEng" id="m_titleEng" maxlength="30" class="form-input">
				</li>				
				<li>
					<label for="m_director">감독</label>
					<input type="text" name="m_director" id="m_director" maxlength="15" class="form-input">
				</li>
				<li>
					<label for="m_actor">배우</label>
					<input type="text" name="m_actor" id="m_actor" maxlength="50" class="form-input">
				</li>
				<li>
					<label for="m_nation">제작국가</label>
					<input type="text" name="m_nation" id="m_nation" maxlength="10" class="form-input">
				</li>
				<li>
					<label for="m_company">제작사</label>
					<input type="text" name="m_company" id="m_company" maxlength="10" class="form-input">
				</li>
				<li>
					<label for="m_opendate">개봉일</label>
					<input type="date" name="m_opendate" id="m_opendate" class="form-input">
				</li>
				<li>
					<label for="m_runtime">상영시간</label>
					<input type="text" name="m_runtime" id="m_runtime" maxlength="3" class="form-input">
				</li>
				<li>
					<label for="m_rating">관람등급</label>
					<input type="text" name="m_rating" id="m_rating" maxlength="8" class="form-input">
				</li>
				<li>
					<label for="m_genre">장르</label>
					<input type="text" name="m_genre" id="m_genre" maxlength="10" class="form-input">
				</li>
				<li>
					<label for="m_poster" class="form-label">포스터</label>
					<input type="file" name="poster" id="poster" accept="image/gif,image/png,image/jpeg"><br>
				</li>
				<li>
					<label for="m_stllimg" class="form-label">스틸컷</label>
					<input type="file" name="stllimg" id="stllimg" accept="image/gif,image/png,image/jpeg"><br>
				</li>
				<li>
					<label for="m_vod" class="form-label">예고편</label>
					<input type="url" name="m_vod" id="m_vod"><br>
				</li>
			</ul>
		</div>
		
		<div id="movie_text">
			<label for="m_plot">줄거리</label>
			<textarea rows="5" cols="60" name="m_plot" id="m_plot" class="form-text"></textarea>
		</div>
		
		<div id="movie_button">
			<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/movie/movieList.do'">
			<input type="button" value="영화 정보 불러오기" id="insertApi">
			<input type="submit" value="등록">
		</div>
	</form:form>
</div>
<!-- 상품 등록 폼 시작 끝 -->