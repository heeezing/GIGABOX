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
    display: flex;
    flex-direction: column; 
    align-items: center;
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
    display: flex;
    flex-direction: column; 
    justify-content: center; 
}
.movie_list li .btm_info {
    display: block;
    margin-top: 14px;
    width: 100%; 
    text-align: center;
}
.movie_list li .top_info .poster_info {
    display: block;
    height: 262px;
}
.movie_list li .top_info .poster_info img {
    width: 100%;
    align-self: center;
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
    margin-top: 20px;
    background: transparent;
    color: #fff !important;
    border-color: #fff;
    width:100px;
    height:25px;
}
.movie_list li .btm_info .sub_info1 .time.blacktype {
    position: relative;
    padding-left: 15px;
    font-weight: 600;
    text-align: center;
}
.movie_list li .btm_info .sub_info1 > span {
    position: relative;
    margin-left: 8px;
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
    /* display: block; */
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
	margin-left:17%;
}
.movie_list li .btm_info .ratingicon,
.movie_list li .btm_info .title_info {
    display: inline-block;
    vertical-align: middle;
}
.title_info{
   	display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    margin-top: 15px;
    text-align: center;
    max-width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; 
}

.movie_list li .btm_info{
 	margin-right:10%;
 	margin-top:0;
}
.movie-search {
  display: flex;
  justify-content: center;
  align-items: center;
}

.movie-search select,
.movie-search .search {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 5px;
  margin-right: 10px;
  display: flex;
  align-items: center;
}

.movie-search select {
  background-color: white;
  cursor: pointer;
}
.movie-search .searchbtn {
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

.movie-search .searchbtn img {
  width: 20px;
  height: 20px;
  vertical-align: middle;
}

.movie-search input[type="button"] {
  background: #e1e1e1;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
  color: #333;
}
#search_form{
	margin-left:30%;
	margin-bottom:30px;
	margin-top:10px;
}
#keyword{
	border-style:none;
}
#keyfield{
	height:35px;
	width:60px;
}
.searchbox{
	border: 1px solid #ccc;
  	border-radius: 5px;
	width:200px;
}
.tit_info{
	display:flex;
}
.poster_info img {
    width: 182px !important;; /* 원하는 너비로 조정 */
    height: 260px !important; /* 높이는 자동 조정 */
  }
</style>
<script type="text/javascript">
	$(function() {
		//검색 유효성 체크
		$('#pre_search_form').submit(function() {
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
	<form action="premovieList.do" id="pre_search_form" class="list-search" method="get" style="border-style:none;">
		<div >
			<div class="movie-search">
				<div class="searchfield">
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화감독</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>영화배우</option>
					</select>
				</div>	
				<div class="searchbox">
					<input type="search" name="keyword" id="keyword" placeholder="검색어를 입력하세요" class="input-text" value="${param.keyword}">
					<button type="submit" name="searchbtn" class="searchbtn">
						<img src="${pageContext.request.contextPath}/images/searchbtn.png" alt="찾기">
					</button>
					<!-- <input type="button" value="목록" onclick="location.href='movieList.do'"> -->
				</div>
			</div>
		</div>
		<br>
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
							<c:if test="${!empty movie.m_poster}"><img src="../movie/imageView.do?movie_num=${movie.movie_num}&movie_type=1"></c:if>
							<c:if test="${empty movie.m_poster}"><img src="${movie.m_poster2}" alt="${movie.m_title}"></c:if>
							<!--<em class="num_info">${movie.m_rank}</em> 영화 랭킹 일단 비활성화해뒀어  -->
						</span>
						<div class="over_box"> <!-- 박스 안 버튼 -->
							<div class="inner" style="margin-top: -33px;">
								<%-- <span><a href="${pageContext.request.contextPath}/reservation/quick_res.do?movie_num=${movie.movie_num}"  class="btn_col3 ty3 btn_booking">예매하기</a></span> --%>
								<span><a href="movieDetail.do?movie_num=${movie.movie_num}" class="btn_col3 ty3 btn_details">상세정보</a></span>
							</div>
						</div>
					</div>
					<div class="btm_info"> <!-- 포스터 밑에!! -->
						<div class="tit_info">
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
							<c:if test="${ratingNumber == '18'}">
						   		<img src="${pageContext.request.contextPath}/images/18.png"  class="ratingicon">
							</c:if>
							<strong class="title_info"><span>${movie.m_title}</span></strong><br>
						</div>
						<div class="sub_info">
							<span class="sub_info1 time blacktype">${movie.m_runtime}분</span>
						</div>
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
