<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
    <script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
</head>
<body>
<script type="text/javascript">
//swiper!
$(function(){
	if( $('.event-swiper').length > 0 ){
		var event_swiper = new Swiper('.event-swiper', {
			autoplay: {
				delay: 3000,
				disableOnInteraction: true,
			},
			loop : true,
			slidesPerView: 2,
			spaceBetween: 40,
			pagination: {
				el: '.event-pagination',
				//type: 'fraction',
				clickable: false,
			},
			navigation : {
				prevEl : '.event-prev',
				nextEl : '.event-next',
			},
			ally : {
				enabled : true
			}
		});

		// swiper 전체 count
		all_count = $('.event-swiper .cell').length;
		dupli_count = $('.event-swiper .swiper-slide-duplicate').length;
		real_count = all_count - dupli_count;

		if('16' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		$('.event-slider .event-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){

			$('.event-prev').hide();
			$('.event-next').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		event_swiper.on('slideChange', function(){
			if('16' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		});

		// 자동실행 정지
		$('.event-util .pause').on('click', function(){
			event_swiper.autoplay.stop();

			$(this).removeClass('on');
			$('.event-util .play').addClass('on').focus();
		});

		// 자동실행 시작
		$('.event-util .play').on('click', function(){
			event_swiper.autoplay.start();

			$(this).removeClass('on');
			$('.event-util .pause').addClass('on').focus();
		});

		// 좌우 이동시 자동실행 정지됨
		$(document).on('click','.event-prev, .event-next', function(){
			$('.event-util .pause').removeClass('on');
			$('.event-util .play').addClass('on');
		});


		$(window).resize(function(){
			event_swiper.update();
		}).resize();
	}
});
</script>

<div class="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
                <a href="eventList.do" title="이벤트 메인 페이지로 이동">이벤트</a>
                <a href="eventList.do" title="진행중 이벤트 페이지로 이동">진행중 이벤트</a>
			</div>
		</div>
	</div>
	<div id="contents">
		<div class="inner-wrap">
				<h2 class="tit">진행중인 이벤트</h2>
				<div class="tab-list fixed">
					<ul>
						<li id="eventTab_0"><a href="eventList.do" title="전체">전체</a></li>
						<c:forEach var="event3" items="${list3}">
						<li id="eventTab_${event3.category_num}"><a href="eventActiList.do?detail=${event3.category_num}" title="메가Pick 탭으로 이동">${event3.category_name}</a></li>
						</c:forEach>
					</ul>
				</div>
		</div>
			<div id="divTopArea" class="event-slider">
				<div class="inner-wrap">
					<p class="name">추천 이벤트</p>
					<div class="event-pagination"></div>
					<div class="event-count">
						<span title="현재 페이지" class="active">0</span> /
						<span title="전체 페이지" class="total">0</span>
					</div>
					<div class="event-util">
						<button type="button" class="event-prev">이전 이벤트 보기</button>
						<button type="button" class="event-next">다음 이벤트 보기</button>
						<button type="button" class="pause on">일시정지</button>
						<button type="button" class="play">자동재생</button>
					</div>

					<div class="event-control">
						<button type="button" class="event-prev">이전 이벤트 보기</button>
						<button type="button" class="event-next">다음 이벤트 보기</button>
					</div>
				</div>

				<div class="event-swiper">
					<div class="swiper-wrapper">
						<!-- 반복 -->
						<c:forEach var="event1" items="${list1}">
							<div class="cell swiper-slide">
								<a href="#" data-no="${event1.event_num}" data-netfunnel="N" class="eventBtn" title="${event1.title}">
									<p class="img"><img src="${pageContext.request.contextPath}/event/imageView.do?thumb=${event1.event_num}&thumb_type=2" alt="${event1.title}" ></p>

									<div class="cont">
										<p class="tit">${event1.title}</p>
										<p class="date">${event1.event_start}~${event1.event_end}</p>
									</div>
								</a>
							</div>
							</c:forEach>
							<!-- 반복 -->
					</div>
				</div>
			</div>
	</div>
</div>
<!--// container -->
<!-- 카테고리별 카드 -->
<div id="event-list-wrap">
	<div class="inner-wrap">
		<c:forEach var="event3" items="${list3}">
			<div class="tit-util mt70">
				<h3 class="tit">${event3.category_name}</h3>
				<div class="right">
					<a href="eventActiList.do?detail=${event3.category_num}" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
				</div>
			</div>
				<div class="event-list mt15">
		        	<ul>
		        	<c:forEach var="event2" items="${list2}">
		        	<c:if test="${event3.category_name == event2.category_name}">
		        		<li>
		        			<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event2.event_num}" data-no="${event2.event_num}" data-netfunnel="N" class="eventBtn" title="${event2.title}">
							<p class="img"> <img src="${pageContext.request.contextPath}/event/imageView.do?thumb=${event2.event_num}&thumb_type=1" ></p>
							<p class="tit">
							${event2.title}
							</p>
							<p class="date">
							${event2.event_start}~${event2.event_end}
							</p>
							</a>
		        		</li>
		        	</c:if>
		        	</c:forEach>
		        	</ul>
		       	</div>
       	</c:forEach>
       
	</div>
</div>
</body>
</html>