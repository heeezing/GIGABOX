<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 영화 목록 시작 -->
<style>
div {
    display: block;
}
body, input, button, select, textarea {
    font-size: 12px;
    color: #000;
}

.movie_screen_box {
    position: relative;
    width:80%;
    align-content: center;
    margin-left:12%;
}
.movie_list.type2 {
    margin-bottom: 0;
}
.movie_list {
    overflow: hidden;
    margin-bottom: 50px;
    margin: 0 -7.5px;
}
ul, ol, li {
    list-style: none;
}
ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}
.movie_list.type2 li {
    height: 310px;
    margin-bottom: 42px;
}
.movie_list li {
    float: left;
    position: relative;
    width: 184px;
    margin: 0 7.5px;
    text-align: center;
}
li {
    display: list-item;
    text-align: -webkit-match-parent;
}
.movie_list li .top_info {
    overflow: hidden;
    position: relative;
    height: 262px;
    border-radius: 4px;
}
.movie_list li .btm_info {
    display: block;
    margin-top: 14px;
}
.movie_list li .top_info .poster_info {
    display: block;
    height: 262px;
}
.movie_list li .top_info .poster_info img {
    width: 100%;
}

img {
    border: none;
    vertical-align: top;
}
img {
    overflow-clip-margin: content-box;
    overflow: clip;
}
.movie_list li .top_info .poster_info .num_info {
    display: block;
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 23px;
    padding-left: 10px;
    color: #fff;
    font-weight: bold;
    font-size: 26px;
}
.btn_col3 {
    display: block;
    line-height: 26px;
    margin-top: 10px;
    background: transparent;
    color: #fff !important;
    border-color: #fff;
}
.movie_list li .btm_info .sub_info1 .time.blacktype {
    position: relative;
    padding-left: 15px;
    font-weight: 600;
}
.movie_list li .btm_info .sub_info1 > span {
    position: relative;
    margin-left: 8px;
}

.movie_list li .top_info:hover .poster_info img {
    filter: brightness(40%);
}

.movie_list li .top_info:hover .over_box .btn_col3 {
    opacity: 5; 
}
.btn_booking .btn_details{
	color: #000!important;
}
.movie_list li .top_info .over_box {
    display: none;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    padding: 10px;
    border-radius: 4px;
    opacity: 0;
    transition: opacity 0.3s ease-in-out;
}

.movie_list li .top_info:hover .over_box {
    display: block;
    opacity: 1;
}

.movie_list li .top_info:hover .over_box .btn_col3 {
    display: block;
    margin-top: 10px;
    background: transparent;
    color: #fff !important;
    border-color: #fff;
    border: 1px solid #fff;
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 14px;
    transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
}
.movie_list li .top_info:hover .over_box .btn_col3:hover {
    background-color: #fff;
    color: #000 !important;
    border-color: #fff;
}
.ratingicon{
	width:50px;
	height:50px;
}
.movie_list li .btm_info .ratingicon,
.movie_list li .btm_info .title_info {
    display: inline-block;
    vertical-align: middle;
}

.movie_list li .btm_info{
 	margin-right:10%;
 	margin-top:0;
}

</style>
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
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../movie/premovieList.do">상영예정작</a>  
	</div>
</div><br>
<div class="page-main">
	<form action="premovieList.do" id="search_form" class="list-search" method="get">
		<ul class="search">
			<li><select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화감독</option>
					<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>영화배우</option>
			</select></li>
			<li><input type="search" name="keyword" id="keyword"
				value="${param.keyword}"></li>
			<li><input type="submit" value="찾기"> <input
				type="button" value="목록" onclick="location.href='premovieList.do'">
			</li>
		</ul>
		<br>
		<%-- <c:if test="${!empty user}"></c:if>
			<input type="button" value="글쓰기"onclick="location.href='movieRegister.do'"> --%>
	</form>
<c:if test="${count == 0}">
	<div class="result-display">표시할 영화가 없습니다.</div>
</c:if>
<c:if test="${count > 0}">
		<!-- movielist 시작 -->
		<div class="movie_screen_box">
			<ul class="movie_list type2">
				<c:forEach var="movie" items="${movies}">	
					<li class="screen_add_box">
					<div class="top_info">
						<span class="poster_info">
							<img src="${movie.m_poster2}" alt="${movie.m_title}">
							<!--<em class="num_info">${movie.m_rank}</em> 영화 랭킹 일단 비활성화해뒀어  -->
						</span>
						<div class="over_box"> <!-- 박스 안 버튼 -->
							<div class="inner" style="margin-top: -33px;">
								<span><a href="" class="btn_col3 ty3 btn_booking">예매하기</a></span>
								<span><a href="movieDetail.do?movie_num=${movie.movie_num}" class="btn_col3 ty3 btn_details">상세정보</a></span>
							</div>
						</div>
					</div>
					<div class="btm_info"> <!-- 포스터 밑에!! -->
						<c:set var="ratingNumber" value="${fn:substring(movie.m_rating, 0, 2)}" />
						<c:if test="${ratingNumber == '12'}">
					 		<img src="${pageContext.request.contextPath}/images/12.png"  class="ratingicon">
						</c:if>
						<c:if test="${ratingNumber == '15'}">
					  		<img src="${pageContext.request.contextPath}/images/15.png"  class="ratingicon">
						</c:if>
						<c:if test="${ratingNumber == '전체'}">
					   		<img src="${pageContext.request.contextPath}/images/ALL.png"  class="ratingicon">
						</c:if>
						<c:if test="${ratingNumber == '청소'}">
					   		<img src="${pageContext.request.contextPath}/images/18.png"  class="ratingicon">
						</c:if>
						<strong class="title_info"><span>${movie.m_title}</span></strong><br>
						<span class="sub_info1 time blacktype">${movie.m_runtime}분</span>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>
		<!-- movielist 끝-->
	<div class="page-button align-center">${page}</div>
</c:if>
</div>
</div>
<!-- 영화 목록 끝 -->
