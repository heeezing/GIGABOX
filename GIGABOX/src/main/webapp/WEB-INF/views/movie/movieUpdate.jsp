<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
.title{
	font-size:30px;
}
form{
	border-style:none;
}  
li{
	list-style-type: none;
}
#m_poster{
	width:40%;
	float:left;
	text-align:center;
	margin-left:18%	;
	margin-bottom:20px;
}
.m_status{
	margin-bottom:15px;
}
#form_input{
	width:60%;
	float:right;
}
#insert_form, #update_form{
	width:880px;
	margin:0 auto;
	padding-top:40px;
	border:1px solid #000;
}
#insert_form label, #update_form label{
	font-weight:bold;
	width:80px;
	margin:0 auto;
	vertical-align:middle;
}
#insert_form ul li, #update_form ul li{
	margin:10px 0;
	vertical-align:middle;
}
input.form-input{
	width:300px;
}
#movie_text{
	clear:both;
	margin:0 auto;
	height:90px;
}
#movie_text label{
	margin-left:50px;
	margin-bottom:20px;
}

#movie_text textarea{
	float:right;
	margin-right:66px;
	resize:none;
	width:80%;
	height:60px;
}

#movie_button{
	text-align:center;
	margin:20px auto;
	clear:both;
}
#m_poster2{
	margin-bottom:20px;
}
#m_stllimg2{
	margin-left:100px;
	margin-bottom:20px;
}
.iframe{
  text-align: center; /* iframe을 가로로 가운데로 정렬 */
  margin: 0 auto;     /* 컨테이너 자체를 가로로 가운데로 정렬 */
}
.iframe iframe {
  max-width: 100%;
  width: auto;
  display: inline-block; 
  vertical-align: middle; 
  margin-bottom:30px;
}
#m_vod{
	margin-right:145px;
}
#movie_button {
  display: flex;
  justify-content: center; /* 가운데 정렬 */
  align-items: center;
  gap: 40px; /* 버튼 사이 간격 설정 */
  margin-top: 30px;
}

.mbtn {
  background-color: white;
  color: black;
  border: 1px solid #ddd;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
  width:100px;
  height:35px;
}
.mbtn:hover{
	border:solid 1px;
	background-color:#f7f8f9;
}
</style>
<!-- 영화 수정 폼 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/movie_register.js"></script>

<div class="page-main">
	<h4 class="title"><a href="movieUpdate.do?movie_num=${movie.movie_num}">영화 수정</a></h4>
	<form:form modelAttribute="movieVO" action="movieUpdate.do" id="update_form" encType="multipart/form-data">
	<form:errors element="div" cssClass="error-color"/>
	<form:hidden path="movie_num"/>
		<li style="border-style:none;">
			<c:if test="${!empty movieVO.m_poster}">
				<img src="../movie/imageView.do?movie_num=${movieVO.movie_num}&movie_type=1" width="400px" height="500px" class="m-poster">
			</c:if>
			<c:if test="${empty movieVO.m_poster}">
				<img src="${movieVO.m_poster2}" width="400px" height="500px" class="m-poster">
			</c:if>
		</li>
		<br>

		<div id="movie_input">
			<ul>
				<li>	
					<input type="radio" name="m_status" class="m_status" value="1" id="status1" <c:if test="${movieVO.m_status == 1}">checked</c:if>>상영
					<input type="radio" name="m_status" class="m_status"  value="2" id="status2" <c:if test="${movieVO.m_status == 2}">checked</c:if>>상영예정
					<input type="radio" name="m_status" class="m_status"  value="3" id="status3" <c:if test="${movieVO.m_status == 3}">checked</c:if>>상영중지
				</li>
				<li>
					<label for="m_title">영화제목</label>
					<input type="text" name="m_title" id="m_title" maxlength="30" class="form-input" value="${movieVO.m_title}">
				</li>
				<li>
					<label for="m_titleEng">영문제목</label>
					<input type="text" name="m_titleEng" id="m_titleEng" maxlength="30" class="form-input" value="${movieVO.m_titleEng}">
				</li>				
				<li>
					<label for="m_director">감독</label>
					<input type="text" name="m_director" id="m_director" maxlength="15" class="form-input" value="${movieVO.m_director}">
				</li>
				<li>
					<label for="m_actor">배우</label>
					<input type="text" name="m_actor" id="m_actor" maxlength="50" class="form-input" value="${movieVO.m_actor}">
				</li>
				<li>
					<label for="m_nation">제작국가</label>
					<input type="text" name="m_nation" id="m_nation" maxlength="10" class="form-input" value="${movieVO.m_nation}">
				</li>
				<li>
					<label for="m_company">제작사</label>
					<input type="text" name="m_company" id="m_company" maxlength="10" class="form-input" value="${movieVO.m_company}">
				</li>
				<c:if test="${!empty movieVO.m_opendate}">
					<li><label for="m_opendate">개봉일</label> 
					<input type="date" name="m_opendate" id="m_opendate" class="form-input" value="${movieVO.m_opendate}"></li>
				</c:if>
				<c:if test="${empty movieVO.m_opendate}">
					<li>
						<label for="m_opendate2">개봉일</label>
						<input type="text" name="m_opendate2" id="m_opendate2" class="form-input" value="${movieVO.m_opendate2}">
					</li>
				</c:if>
				<li>
					<label for="m_runtime">상영시간</label>
					<input type="text" name="m_runtime" id="m_runtime" maxlength="3" class="form-input" value="${movieVO.m_runtime}">
				</li>
				<li>
					<label for="m_rating">관람등급</label>
					<input type="text" name="m_rating" id="m_rating" maxlength="8" class="form-input" value="${movieVO.m_rating}">
				</li>
				<li>
					<label for="m_genre">장르</label>
					<input type="text" name="m_genre" id="m_genre" maxlength="10" class="form-input" value="${movieVO.m_genre}">
				</li>
				
				<li>
				<c:if test="${empty movieVO.m_poster2}">
					<label for="m_poster" class="form-label">포스터</label> 
					<input type="file" name="poster" id="poster" accept="image/gif,image/png,image/jpeg"><br>
				</c:if>
				<c:if test="${!empty movieVO.m_poster2}">
					<li>
						<label for="m_poster2" class="form-label">포스터</label> 
						<input type="url" name="m_poster2" id="m_poster2" value="${movieVO.m_poster2}"><br>
					</li>
				</c:if>
				
				<c:if test="${empty movieVO.m_stllimg2}">
					<li> 
						<label for="m_stllimg" class="form-label">스틸컷</label>
						<img src="../movie/imageView.do?movie_num=${movieVO.movie_num}&movie_type=2"  width="300px" height="300px" class="m-stllimg">
						<input type="file" name="stllimg" id="stllimg" accept="image/gif,image/png,image/jpeg"><br>
					</li>
				</c:if>
				<c:if test="${!empty movieVO.m_stllimg2}"> <!-- api 스틸컷 -->
					<li>
						<label for="m_stllimg2" class="form-label">스틸컷</label> 
						<img src="${movieVO.m_stllimg2}" width="300px" height="300px" class="m-stllimg">
						<input type="url" name="m_stllimg2" id="m_stllimg2" class="form-input" value="${movieVO.m_stllimg2}"><br>
					</li>
				</c:if>			
				<li>
					<label for="m_vod" class="form-label">예고편</label>
					<div class="iframe">
						<c:if test="${movieVO.m_vod == null}">
							<p>등록된 예고편이 없습니다.</p>
							<input type="url" name="m_vod" id="m_vod" class="form-input"><br>
						</c:if>
						<c:if test="${movieVO.m_vod != null}">
							<input type="url" name="m_vod" id="m_vod" class="form-input" value="${movieVO.m_vod}" maxlength=10000>
							<div class="iframe">
							<iframe src="${movieVO.m_vod}" style="width: 500px; height: 300px; border: none;"></iframe>
							</div>
							<br>
						</c:if>
					</div>
				</li>
			</ul>
		</div>
		
		<div id="movie_text">
			<label for="m_plot">줄거리</label>
			<textarea rows="5" cols="60" name="m_plot" id="m_plot" class="form-text">${movieVO.m_plot}</textarea>
		</div>
		
		<div id="movie_button">
			<input type="button" class="mbtn" value="목록" onclick="location.href='${pageContext.request.contextPath}/movie/movieList.do'">
			<input type="submit" class="mbtn" value="수정">
		</div>
</div>
</form:form>
<!-- 영화 수정 폼 끝 -->