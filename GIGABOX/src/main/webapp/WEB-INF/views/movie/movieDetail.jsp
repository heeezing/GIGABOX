<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie.css">
<style>
.tab-list.fixed.movie {
    left: 0;
    right: inherit;
    top: 122px;
    z-index: 50;
    width: 100%;
    box-shadow: 0 0 20px 0 rgba(0,0,0,.12);
}
.tab-list {
    position: static;
    width: 100%;
    background-color: rgba(255,255,255);
}
* {
    box-sizing: border-box;
}
div {
    display: block;
}
.tab-list>ul {
    position: relative;
    width: 100%;
    height: 42px;
}
ol, ul, li {
    list-style-type: none;
    margin: 0;
    padding: 0;
}
* {
    box-sizing: border-box;
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
.tab-list>ul:after {
    content: '';
    display: block;
    position: absolute;
    left: 0;
    bottom: 0;
    z-index: 2;
    width: 100%;
    height: 1px;
    background-color: #503396;
}
.tab-list>ul>li:first-child:nth-last-child(4), .tab-list>ul>li:first-child:nth-last-child(4)~li {
    width: 25%;
}
.tab-list>ul>li.on {
   border-width: 2px 2px 0 2px; /* 상, 우, 하, 좌 순서 */
   border-color: #503396;
}
.tab-list>ul>li {
    float: left;
    height: 42px;
    margin: 0;
    border: 1px solid #ebebeb;
    border-width: 1px 0 1px 1px;
}
li {
    display: list-item;
    text-align: -webkit-match-parent;
}
.tab-list>ul>li .on>a {
    z-index: 3 !important;
    color: #503396;
    background-color: #fff;
}
.tab-list>ul>li>a {
    position: relative;
    display: block;
    width: 100%;
    height: 41px;
    line-height: 40px;
    padding: 0;
    text-align: center;
    color: #222;
    font-size: 1.0667em;
    text-decoration: none;
}
.a:link {
    color: #444;
    text-decoration: none;
}

* {
    box-sizing: border-box;
}

</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/review.js"></script>
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../movie/movieList.do">영화</a> 
		<a href="../movie/movieDetail.do">영화 상세</a> 
	</div>
</div><br>
<!-- ================= 영화 상세 시작 ================= -->
<div class="page-main">
	<!--movie-detailtop 시작-->
	<div class="movie-detailtop">
		<div class="detailtop-left">
			<div class="left1">
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
			</div>
			<div class="left2">
				<h1 class="title">${movie.m_title}</h1>
				<h3 class="titleEng">${movie.m_titleEng}</h3>
			</div>
		</div>
		<div class="detailtop-right">
			<img src="imageView.do?movie_num=${movie.movie_num}&movie_type=1"
				width="400" height="500">
		</div>
		<div class="detailtop-bottom">
			<c:if test="${movie.m_status == 1 }">
				<input type="button" value="예매" class="detail-rightbtn" onclick="">
			</c:if>
			<c:if test="${movie.m_status != 1 }">
				<input type="button" class="detail-rightbtn"value="상영종료">
			</c:if>
		</div>
	</div>	<!-- end of movie-detailtop -->
	<!--movie-detailmain 시작-->
	<div class="movie-detailmain">
		<div class="tab-list fixed movie">
	        <ul class="tabWrap">
	            <li class="wrap_info" data-tab="wrap_info" style="cursor: pointer;"><a class="a" href="movieDetail.do?movie_num=${movie.movie_num}#wrap_info">주요정보</a></li>
	            <li class="wrap_review" data-tab="wrap_review" style="cursor: pointer;"><a class="a" href="movieDetail.do?movie_num=${movie.movie_num}#wrap_review">실관람평</a></li>
	            <li class="wrap_post" data-tab="wrap_post" style="cursor: pointer;"><a class="a" href="movieDetail.do?movie_num=${movie.movie_num}#wrap_post">무비포스트</a></li>
	            <li class="wrap_preview" data-tab="wrap_preview" style="cursor: pointer;"><a class="a" href="movieDetail.do?movie_num=${movie.movie_num}#wrap_preview">예고편/스틸컷</a></li>
	        </ul>
	    </div>
	<!--================= 주요정보 시작 ================= -->
		<div id="wrap_info" class="tab-contents on">
			<div class="content-main container">
				<p class="movie-plot">${movie.m_plot}</p>
				<hr size="1" width="100%">
				<div class="movie-info">
					<ul style="margin-bottom:10px;">
						<li>감독 : ${movie.m_director}</li>
						<li>장르 : ${movie.m_genre}</li>
						<li>상영시간 : ${movie.m_runtime}분</li>
						<li>등급 : ${movie.m_rating}</li>
						<li>개봉일 : ${movie.m_opendate}</li>
						<li>국가 : ${movie.m_nation}</li>
						<li>배급 : ${movie.m_company}</li>
					</ul>
					<ul style="margin-top:0;">
						<li>출연진 : ${movie.m_actor}</li>
					</ul>
				</div>
				<!-- movie-info끝 -->
				<div class="movierating_Avg">
					<p>실관람 평점</p>
					<span>${movie.rating_avg}</span>
				</div>
				<div class="adminbtn">
					<c:if test="${user.auth == 9}">
						<input type="button" value="수정하기" onclick="location.href='movieUpdate.do?movie_num=${movie.movie_num}'">
					</c:if>
				</div>
			</div>
		</div>
		<!-- 주요정보 끝 -->
		
		<!-- ================= 실관람평 시작 ================= -->
		<div id="wrap_review" class="tab-contents">
			<div class="content-main container">
				<div id="review_div">
					<span class="review-title">관람평 쓰기</span>
					<form id="review_form">
						<input type="hidden" name="movie_num" value="${movie.movie_num}" id="movie_num">
						<textarea rows="3" cols="50" name="review_content" id="review_content" class="review-content" <c:if test="${empty user}">disabled="disabled"</c:if>>
							<c:if test="${empty user}">${movie.m_title} 재미있게 보셨나요? 영화의 어떤 점이 좋았는지 이야기해주세요.</c:if>
						</textarea>
						<c:if test="${!empty user}">
							<!-- 별을 이용한 평점 매기기 시작 -->
							<!-- 별을 이용한 평점 매기기 끝 -->
							<div id="review_first">
								<span class="letter-count">220/220</span>
							</div>
							<div id="review_second" class="align-right">
								<input type="submit" value="관람평 작성">
							</div>
						</c:if>
					</form>
				</div> <!--end of review_div -->
				<!-- 관람평 목록  -->	
				<div id="output"></div>
				<div class="paging-button" style="display:none;">
					<input type="button" value="더보기">
				</div>
				<div class="loading" style="display:none;">
					<img src="${pageContext.request.contextPath}/images/loading.gif" width="100" height="100">
				</div>
			</div><!-- end of content-main -->
		</div>
		<!-- 실관람평 끝 -->

		<!-- ================= 무비포스트 시작 =================-->
		<div id="wrap_post" class="tab-contents">
			<div class="content-main container">
			
			</div>
		</div>
		<!-- 무비포스트 끝 -->

		<!-- ================= 예고편/스틸컷 시작 ================= -->
		<div id="wrap_preview" class="tab-contents">
			<div class="content-main container">
				<hr style="border: 1px solid #7d7c7c;">
				<h2 class="previewtitle">메인 예고편</h2>
				<hr><br>
				<div class="iframe">
					<iframe width="700" height="400" src="${movie.m_vod}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
				</div><br>
				<hr style="border: 1px solid #7d7c7c;">
				<h2 class="previewtitle"><span style="color:#503396;">${movie.m_title}</span>에 대한 스틸컷이 있어요!</h2>
				<hr><br>
				<div><img class="stllimg" src="imageView.do?movie_num=${movie.movie_num}&movie_type=2"></div>
			</div>
		</div>
		<!-- 예고편/스틸컷 끝 -->
		
		
		
		<script type="text/javascript">
		$(document).ready(function(){
			$('.tabWrap li').click(function(){
				const getID = $(this).attr('data-tab')
				console.log(getID)
				$(this).addClass('on').siblings().removeClass('on')
				$('.tab_contents').removeClass('on')
				$("#" + getID).addClass('on')
			}); //on붙이기 끝
			
			$(function(){
				$('.wrap_info').on('click',function(){
					$('.tab-contents').hide();
					$('#wrap_info').show();
				});
				$('.wrap_review').on('click',function(){
					$('.tab-contents').hide();
					$('#wrap_review').show();
				});
				$('.wrap_post').on('click',function(){
					$('.tab-contents').hide();
					$('#wrap_post').show();
				});
				$('.wrap_preview').on('click',function(){
					$('.tab-contents').hide();
					$('#wrap_preview').show();
				});
			}); // click 끝
			
			//페이지 로드 시 wrap_info 보이게
			$('.wrap_info').addClass('on').siblings().removeClass('on')
			$('.tab-contents').hide();
			$('#wrap_info').show();
		});
		</script>
	</div>
	<!--end of movie-detailmain -->
</div>



