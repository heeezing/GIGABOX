<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/movie.css">
<!-- 영화 상세 시작 -->
<div class="page-main">
	<div class="movie-detailtop">
		<div class="detailtop-left">
			<h2>${movie.m_title}</h2>
			<h4>${movie.m_titleEng}</h4>
		</div>
		<div class="detailtop-right">
			<img src="imageView.do?movie_num=${movie.movie_num}&movie_type=1"
				width="400" height="400">
		</div>
		<div class="detail-rightbtn">
			<c:if test="${movie.m_status ==1 }">
				<input type="button" value="예매" onclick="">
			</c:if>
			<c:if test="${movie.m_status != 1 }">
				<input type="button" value="상영종료">
			</c:if>
		</div>
	</div>
	<!-- end of detailtop -->
	<div class="movie-detailmain">
		<div>
			<hr>
			<ul class="tabWrap">
				<%--myPage.do#admin_book 북다방에서는 주소를 이렇게 명시 --%>
				<li data-tab="wrap_info" style="cursor: pointer;" class="on"><a
					href="">주요정보</a></li>
				<li data-tab="wrap_review" style="cursor: pointer;"><a href="">실관람평</a></li>
				<li data-tab="wrap_post" style="cursor: pointer;"><a href="">무비포스트</a></li>
				<li data-tab="wrap_preview" style="cursor: pointer;"><a href="">예고편/스틸컷</a></li>
			</ul>
			<hr>
		</div>
		<!-- end of detailwrap -->
		<!-- 주요정보 시작 -->
		<div id="wrap-info" class="tab_contents on">
			<div class="content-main container">
				<p class="movie-plot">${movie.m_plot}</p>
				<hr size="1" width="100%">
				<div class="movie-info">
					<ul>
						<li>감독 : ${movie.m_director}</li>
						<li>|</li>
						<li>장르 : ${movie.m_genre}</li>
						<li>|</li>
						<li>상영시간 : ${movie.m_runtime}분</li>
						<li>|</li>
						<li>등급 : ${movie.m_rating}</li>
						<li>|</li>
						<li>개봉일 : ${movie.m_opendate}</li>
						<li>|</li>
						<li>국가 : ${movie.m_nation}</li>
						<li>|</li>
						<li>배급 : ${movie.m_company}</li>
					</ul>
					<ul>
						<li>출연진 : ${movie.m_actor}</li>
					</ul>
				</div>
				<!-- movie-info끝 -->
			</div>
			<!-- content-main container끝 -->
		</div>
		<!-- 주요정보 끝 -->

		<!-- 실관람평 시작 -->
		<div id="wrap_review" class="tab-contents">
			<div class="content-main container"></div>
		</div>
		<!-- 실관람평 끝 -->

		<!-- 무비포스트 시작 -->
		<div id="wrap_post" class="tab-contents">
			<div class="content-main container"></div>
		</div>
		<!-- 무비포스트 끝 -->

		<!-- 예고편/스틸컷 시작 -->
		<div id="wrap_preview" class="tab-contents">
			<div class="content-main container"></div>
		</div>
		<!-- 예고편/스틸컷 끝 -->
	</div>
</div>

<script type="text/javascript">
	$(function() {
		let hash = window.location.hash;
		if (hash) {
			$(this).addClass('on').siblings().removeClass('on')
			$('.tab_contents').removeClass('on')
			$(hash).addClass('on')
			$('.tabWrap li').removeClass('on');
			$('.tabWrap').find('li[data-tab=' + hash.substring(1) + ']')
					.addClass('on');
		}
	});
</script>

