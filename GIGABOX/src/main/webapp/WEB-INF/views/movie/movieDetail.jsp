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
.a {
    z-index: 3 !important;
    color: #503396;
    background-color: #fff;
}
.a {
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
.a{
    color: #444;
    text-decoration: none;
}

* {
    box-sizing: border-box;
}
  .movie-detailtop {
    position: relative;
    width: 100%;
    height: 100vh;
    /* display: flex; */
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }
  .background-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('${movie.m_poster2}');
    background-size: cover;
    filter: blur(10px); /* 흐림 효과 적용 */
    z-index: -1;
  }

  .background-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: black;
    opacity: 0.7;
    z-index: -1;
  }
  .detail-content{
  	margin-top:5%;
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
	 <div class="background-image"></div>
	  <div class="background-overlay"></div>
	  <div class="detail-content">
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
			<img src="${movie.m_poster2}">
		</div>
		<div class="detailtop-bottom">
			<c:if test="${movie.m_status == 1 }">
				<input type="button" value="예매" class="detail-rightbtn" onclick="">
			</c:if>
			<c:if test="${movie.m_status == 2 }">
				<input type="button" class="detail-rightbtn disabled-btn"value="상영예정">
			</c:if>
			<c:if test="${movie.m_status == 3 }">
				<input type="button" class="detail-rightbtn disabled-btn"value="상영종료">
			</c:if>
		</div>
	</div>
	</div>	<!-- end of movie-detailtop -->
	<!--movie-detailmain 시작-->
	<div class="movie-detailmain">
		<div class="tab-list fixed movie">
	        <ul class="tabWrap">
	            <li class="wrap_info a" data-tab="wrap_info" style="cursor: pointer;">주요정보</li>
	            <li class="wrap_review a" data-tab="wrap_review" style="cursor: pointer;">실관람평</li>
	            <li class="wrap_post a" data-tab="wrap_post" style="cursor: pointer;">무비포스트</li>
	            <li class="wrap_preview a" data-tab="wrap_preview" style="cursor: pointer;">예고편/스틸컷</li>
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
					<span class="ratingAvg">0</span>
				</div>
				<div class="adminbtn">
					<c:if test="${user.auth == 9}">
						<input type="button" value="수정하기" onclick="location.href='movieUpdate.do?movie_num=${movie.movie_num}'">
					</c:if>
				</div><br>
				
					<!-- 	<!-- 관람평 목록  -->	
				</div><!--end of pre-review-->
			</div><!--end of content-main container-->
		</div>
		<!-- 주요정보 끝 -->
		
		<!-- ================= 실관람평 시작 ================= -->
		<div id="wrap_review" class="tab-contents">
			<div class="content-main container">
				<div class="pre-review">
					<div class="pre-review-countreview">
						<span>${movie.m_title}</span>
						<span>에 대한 </span>
						<span class="reviewCount">0</span>
						<span>개의 이야기가 있어요!</span>
					</div>
					<div class="reviewbox">
						<div class="reviewbox-profile">
							<img src="${pageContext.request.contextPath}/member/photoView.do" class="my-photo">
						</div>
						<div class="nick-name">
							<c:if test="${!empty member.nick_name}">
								${member.nick_name}
							</c:if>
							<c:if test="${empty member.nick_nick_name}">
								${member.id}
							</c:if>
						</div>
						<div class="reviewboxcontent">
							<div class="reviewbox-title">
								<span style="color: #503396; font-weight:600; margin-left:15px;">${movie.m_title}</span>
								<span>재미있게 보셨나요? 영화의 어떤 점이 좋았는지 이야기해주세요.</span>
							</div>
							<div class="reviewbox-btn">
							<input type="button" value="관람평 쓰기" id="openrwButton">
							</div>
						</div>
					</div><!-- end of review-box -->
					<!-- 모달 -->
					<div class="rw-modal" id="rw-modal">
    					<div class="rw-content">
       					 <!-- 모달 내용 -->
       				<div id="review_div">
					<form id="review_form">
						<input type="hidden" name="movie_num" value="${movie.movie_num}" id="movie_num">
						<!-- 관람평 평점 입력 -->
						<h3 class="align-center" style="letter-spacing: 1.8px;"><span style="color:#503396; font-size:20px;">${movie.m_title }</span>의 평점을 선택해주세요.</h3>
						<div class="rating-wrap align-center"> 
							<fieldset class="rating_score">
					        	<input type="radio" name="rating_score" value="10" id="star10"/><label for="star10" class="full"></label>
					        	<input type="radio" name="rating_score" value="9" id="star9"/><label for="star9" class="half"></label>
					        	<input type="radio" name="rating_score" value="8" id="star8"/><label for="star8" class="full"></label>
					        	<input type="radio" name="rating_score" value="7" id="star7"/><label for="star7" class="half"></label>
					        	<input type="radio" name="rating_score" value="6" id="star6"/><label for="star6" class="full"></label>
					        	<input type="radio" name="rating_score" value="5" id="star5"/><label for="star5" class="half"></label>
					        	<input type="radio" name="rating_score" value="4" id="star4"/><label for="star4" class="full"></label>
					        	<input type="radio" name="rating_score" value="3" id="star3"/><label for="star3" class="half"></label>
					        	<input type="radio" name="rating_score" value="2" id="star2"/><label for="star2" class="full"></label>
					        	<input type="radio" name="rating_score" value="1" id="star1"/><label for="star1" class="half"></label>
					        </fieldset>
					        <span class="rating-value" style="font-size: 40px; font-weight:1000; color: #000;" >0</span>
					        <span style="font-size: 14px; font-weight: bold; color: #333; margin-top:25px; margin-left:10px;">&nbsp;/&nbsp; 10</span>
				        </div>
						<!-- 관람평 평점 입력 끝 -->
								<textarea rows="3" cols="50" name="review_content" id="review_content" class="review-content" <c:if test="${empty user}">disabled="disabled"</c:if>
								><c:if test="${empty user}"></c:if></textarea>
								<c:if test="${!empty user}">
									<div id="review_first">
										<span class="letter-count align-right">220/220</span>
									</div>
									<div id="review_second" class="align-center">
										<input type="button" value="취소하기" class="review-cancel-btn">
										<input type="button" value="작성하기" class="review-btn">
									</div>
								</c:if>
							</form>
						</div> <!--end of review_div -->	
   						</div> <!-- end of reviewwritemodal-content -->
					</div>
						
				<!-- 관람평 목록  -->	
				<div id="output">
				</div>
				<div class="paging-button">
					<input type="button" value="더보기 &gt;">
				</div>
		</div><!-- end of content-main -->
		<!-- 실관람평 끝 -->
 		</div>
		</div>
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
					<iframe src="${movie.m_vod}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"></iframe>
				</div><br>
				<hr style="border: 1px solid #7d7c7c;">
				<h2 class="previewtitle"><span style="color:#503396;">${movie.m_title}</span>에 대한 스틸컷이 있어요!</h2>
				<hr><br>
				<div><img src="${movie.m_stllimg2}"></div>
			</div>
		</div>
		<!-- 예고편/스틸컷 끝 -->
	</div>
	<!--end of movie-detailmain -->



	<script type="text/javascript">
		$(document).ready(function() {
			$('.tabWrap li').click(function() {
				const getID = $(this).attr('data-tab')
				console.log(getID)
				$(this).addClass('on').siblings().removeClass('on')
				$('.tab_contents').removeClass('on')
				$("#" + getID).addClass('on')
			}); //on붙이기 끝

			$(function() {
				$('.wrap_info').on('click', function() {
					$('.tab-contents').hide();
					$('#wrap_info').show();
				});
				$('.wrap_review').on('click', function() {
					$('.tab-contents').hide();
					$('#wrap_review').show();
				});
				$('.wrap_post').on('click', function() {
					$('.tab-contents').hide();
					$('#wrap_post').show();
				});
				$('.wrap_preview').on('click', function() {
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