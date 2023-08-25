<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.gnb>li>a, #top_left li a, #top_right li a{
	color: white;
}
header{
	background-color: #130f40;
	background-image: linear-gradient(90deg, #130f40 0%, #000000 74%);
}
.btn4::before {
	background: white;
}
.bg_gnb {
	background-color: #a399b2;
	background-image: linear-gradient(147deg, #a399b2 0%, #4d4855 95%);
}
.gnb>li ul li a:hover, .gnb>li ul li a:focus {
	font-weight:600;
	color: #000;
}
</style>
<script type="text/javascript">
<!-- 전체 메뉴 상단 링크 적용 스크롤 이벤트 -->
$(window).on("scroll",function(){
    if( $(window).scrollTop() > 100){
      $(".page-util").addClass("fixed");
    }else {
      $(".page-util").removeClass("fixed");
    }
  });

<!-- 헤더 서브 메뉴 show/hide -->
$(document).ready(function() {
	$('.has-sub').on('mouseover focusin', function() {
		// 마우스를 메뉴 항목 위로 올리거나 포커스가 들어올 때
		$(this).children('ul').stop().fadeIn(300); // 하위 메뉴를 나타나게 합니다.
	});
	$('.has-sub').on('mouseleave', function() {
		// 마우스가 메뉴 항목을 벗어날 때
		$(this).children('ul').stop().fadeOut(300); // 하위 메뉴를 숨깁니다.
	});
	$('.has-sub').on('mouseover focusin', function() {
		$('.bg_gnb').stop().fadeIn(200);
	})
	$('.has-sub').on('mouseleave focusout', function() {
		$('.bg_gnb').stop().fadeOut(200);
	})
	//1뎁스 메뉴에서 키보드 초점이 벗어나면 ul이 없어지는 작용을 한다.
	$('.gnb > li').on('focusout', function() {
		$(this).children('ul').stop().fadeOut(200);
	})
});
</script>
<!-- 헤더 시작 -->
<header style="border-bottom: 2px solid #000;">
	<div class="page-main">
		<!-- 상단 -->
		<div id="top_left">
			<ul>
				<li><a href="<c:url value="/cs/csMain.do" />">고객센터</a></li>
				<li><a href="${pageContext.request.contextPath}/reservation/quick_res.do">빠른예매</a></li>
			</ul>
		</div>
		
		<div id="top_right">
			<ul>
				<c:if test="${empty user}">
				<li><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
				<li><a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a></li>
				</c:if>
			</ul>
	
			<ul>
				<c:if test="${!empty user}">
					<li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
					
					<c:if test="${user.auth == 2}">
					<li>
						<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
					</li>
					</c:if>
					
					<c:if test="${user.auth == 9}">
					<li style="width: 70px;">
						<a href="${pageContext.request.contextPath}/board/memberList.do">관리자메인</a>
					</li>
					</c:if>
				</c:if>
			</ul>
		</div>
	
		<div id="main_nav">
			<ul class="gnb">
				<li class="has-sub">
					<a href="${pageContext.request.contextPath}/movie/movieList.do" class="btn4">영화</a>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/movie/movieList.do">현재상영작</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/movie/premovieList.do">상영예정작</a>
						</li>
					</ul>
				</li>
				
				<li>
					<a href="${pageContext.request.contextPath}/theater/theaterDetail.do" class="btn4">극장</a>
				</li>
				
				<li class="has-sub">
					<a href="${pageContext.request.contextPath}/reservation/quick_res.do" class="btn4">예매</a>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/reservation/quick_res.do">빠른예매</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/reservation/schedule.do">상영시간표</a>
						</li>
					</ul>
				</li>
				
				<li id="logo">
					<a href="${pageContext.request.contextPath}/main/main.do">
						<img src="${pageContext.request.contextPath}/images/logo_w.png" width="160">
					</a>
				</li>
				
				<li class="has-sub">
					<a href="<c:url value="/event/eventList.do" />" class="btn4">이벤트</a>
					<ul>
						<li><a href="<c:url value="/event/eventList.do" />">진행중이벤트</a></li>
						<li><a href="<c:url value="/event/eventEndList.do" />">지난이벤트</a></li>
					</ul>
				</li>
				
				<li><a href="${pageContext.request.contextPath}/snack/list.do" class="btn4">스토어</a></li>
					
				<li><a href="${pageContext.request.contextPath}/membership/membership_list.do" class="btn4">멤버십</a></li>
			</ul>
		</div>
	</div>
</header>
<!-- 서브 메뉴 -->
<div class="bg_gnb"></div>  
<!-- 헤더 끝 -->
