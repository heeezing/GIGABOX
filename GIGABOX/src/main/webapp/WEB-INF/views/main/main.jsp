<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Owl Carousel CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<!-- Owl Carousel JS -->
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script type="text/javascript">
//배너
$(document).ready(function () {
    $(".owl-carousel").owlCarousel({
        loop: true,             // 무한 루프
        margin: 0,             // 이미지 간 간격
        nav: true,              // 이전/다음 버튼 표시
        dots: true,             // 페이지 버튼 표시
        autoplay: true,         // 자동 슬라이드
        autoplayTimeout: 7000, // 자동 슬라이드 간격 (밀리초)
        responsive: {
            0: {
                items: 1       // 화면 너비 0px 이상에서 1개 항목 표시
            }
        }
    });
});
</script>
<!-- 내용 시작 -->
<!-- 배너 -->
<div>
	<div class="owl-carousel">
	    <div class="item">
	    	<img src="${pageContext.request.contextPath}/images/main_banner01.jpg" alt="콘크리트 유토피아">
		</div>
	    <div class="item">
	    	<img src="${pageContext.request.contextPath}/images/main_banner02.jpg" alt="보호자">
		</div>
	    <div class="item">
	    	<img src="${pageContext.request.contextPath}/images/main_banner03.jpg" alt="한 남자">
		</div>
	</div>
</div>

<!-- 박스 오피스 -->
<div class="dark-wrap">
	<div class="page-main" style="padding-top:40px;">
		<div id="btn_wrap">
			<div id="container"><h1>BOX OFFICE</h1></div>
			<a href="${pageContext.request.contextPath}/movie/movieList.do" id="btn_allMovie">전체보기 ></a>
		</div>
	</div>	
	
	<div>
		<ul class="movie_list">
			<c:forEach var="movie" items="${mList}"  varStatus="loop">	
			<li class="screen_add_box">
				<div class="top_info">
				<a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}" class="go-to-detail">
					<span class="poster_info">
						<c:set var="movieIndex" value="${loop.index + 1}" />
              			<span class="rank">${movieIndex}</span>
						<c:if test="${!empty movie.m_poster}"><img src="../movie/imageView.do?movie_num=${movie.movie_num}&movie_type=1"></c:if>
						<c:if test="${empty movie.m_poster}"><img src="${movie.m_poster2}" alt="${movie.m_title}"></c:if>
					</span>
					<span class="over_box"> <!-- 박스 안 버튼 -->
							${movie.m_plot}
					</span>
				</a>
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
					<strong id="title_info">${movie.m_title}</strong>
					<span style="padding:6px 0 0 6px; font-size:9pt;">| ${movie.m_runtime}분</span>
				</div>
				
				<div class="btn-util">
					<a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}" class="button btn-like">상 세</a>
					<div class="case">
						<a href="${pageContext.request.contextPath}/reservation/quick_res.do?movie_num=${movie.movie_num}" class="button gblue">예 매</a>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

<!-- 멤버십 -->
<div class="membership-wrap">
	<div class="membershipCard">
		<div class="tt">GIGABOX<span>MEMBERSHIP</span></div>
		<div class="tx">멤버십 구독으로 포인트 적립 혜택을 만나보세요!</div>
		<img src="${pageContext.request.contextPath}/images/main_card.png">
		<div class="mbs-btn-wrap">
			<button class="mbs-btn" onclick="location.href='${pageContext.request.contextPath}/membership/membership_list.do'">구독하러 가기 ></button>
		</div>
	</div>
</div>

<!-- 이벤트 -->
<div class="event-wrap">
	<div class="event-list">
		<div class="ev-title-wrap"> 
			<div class="ev-title">E V E N T</div>
			<span class="ev-sub">혹시 이번엔 내가 당첨자?! 놓치지 말고 신청해보세요!</span>
			<div class="ev-more">
				<a href="${pageContext.request.contextPath}/event/eventList.do">+</a>
			</div>
		</div>
		<div class="ev-list">
			<c:forEach var="event" items="${eList}">
			<div class="event-detail">
				<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}">
					<img src="${pageContext.request.contextPath}/event/imageView.do?thumb=${event.event_num}&thumb_type=1">
					<span style="font-size:12pt;">${event.title}</span><br>
					<span style="color:gray;">
					<fmt:formatDate value="${event.event_start}" pattern="yy-MM-dd"/>
					~ <fmt:formatDate value="${event.event_end}" pattern="yy-MM-dd"/>
					</span>
				</a>
			</div>
			</c:forEach>
		</div>
	</div>
</div>

<!-- 공지사항/고객센터 -->
<div class="page-main">

	<div class="main_cont_wrap notice">
		<div class="sec_tit">공지사항</div>
		<div class="rolling_menu_wrap">
			<c:forEach var="notice" items="${nList}">
			<a href="${pageContext.request.contextPath}/cs/csDetail.do?noti_num=${notice.noti_num}">
				${notice.title}
			</a>
			</c:forEach>
		</div>
		<a href="${pageContext.request.contextPath}/cs/csNotiList.do" class="btn_txt_more ty2">더보기</a>
	</div>
	
	<div class="noticeClient_wrap">
		<div class="contents">
			<!-- 고객센터 박스 -->
			<div class="noticeClient_container">
				<div class="noticeClient_content">
					<div class="client_wrap">
						<img src="${pageContext.request.contextPath}/images/main_cs_icon.png"
							 width="100px;">
						<dl class="client_list">
							<dd>
								<strong style="font-size: 12pt;">고객센터</strong>
								<strong style="font-size: 12pt;">1004-1004</strong>
								<span>운영시간 | 평일 09:00~18:00</span>
								<p>업무시간 외 자동응답 안내 가능합니다.</p>
							</dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- 자주묻는질문, 1:1문의 아이콘 -->
			<div class="table">
				<div class="cell">
					<a href="${pageContext.request.contextPath}/cs/csQnaList.do">
						<img src="${pageContext.request.contextPath}/images/main_question_icon.png" width="90px"><br>
						<span class="cs-sub">자주 묻는 질문</span>
					</a>
				</div>
	
				<div class="cell">
				<a href="${pageContext.request.contextPath}/cs/csPersonalWrite.do">
					<img src="${pageContext.request.contextPath}/images/main_one_icon.png" width="90px"><br>
					<span class="cs-sub">1:1 문의</span>
				</a>
				</div>
			</div>
		</div>
	</div>
	
</div>

<!-- 내용 끝 -->