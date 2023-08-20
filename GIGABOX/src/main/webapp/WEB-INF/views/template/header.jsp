<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 전체 메뉴 상단 링크 적용 스크롤 이벤트 -->
<script type="text/javascript">
$(window).on("scroll",function(){
    if( $(window).scrollTop() > 100){
      $(".page-util").addClass("fixed");
    }else {
      $(".page-util").removeClass("fixed");
    }
  });
</script>
<!-- 헤더 시작 -->
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
			<li><a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a></li>
			</c:if>
			<c:if test="${user.auth == 9}">
			<li style="width:80px;"><a href="${pageContext.request.contextPath}/main/admin.do">관리자메인</a></li>
			</c:if>
			</c:if>
		</ul> 
	</div>

	<!-- 메뉴 -->
	<div id="main_nav">
		<ul>
			<li class="outer-menu-item">
				<a href="#" class="btn4"><b>영화</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/movie/movieList.do">박스오피스</a></li>
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/movie/premovieList.do">상영예정작</a></li>
					<li class="inner-menu-item"><a href="#">무비포스트</a></li>
				</ul>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/theater/theaterDetail.do" class="btn4"><b>극장</b></a>
			</li>
			<li class="outer-menu-item">
				<a href="${pageContext.request.contextPath}/reservation/quick_res.do" class="btn4"><b>예매</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/reservation/quick_res.do">빠른예매</a></li>
					<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/reservation/schedule.do">상영시간표</a></li>
				</ul>
			</li>
			<li id="logo">
				<a href="${pageContext.request.contextPath}/main/main.do">
					<img src="${pageContext.request.contextPath}/images/logo_p.png" width="160">
				</a>
			</li>
			<li class="outer-menu-item">
				<a href="#" class="btn4"><b>이벤트</b></a>
				<ul class="inner-menu">
					<li class="inner-menu-item"><a href="<c:url value="/event/eventList.do" />">진행중이벤트</a></li>
					<li class="inner-menu-item"><a href="<c:url value="/event/eventEndList.do" />">지난이벤트</a></li>
					<li class="inner-menu-item"><a href="<c:url value="/event/eventResultList.do" />">당첨자발표</a></li>
				</ul>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/snack/list.do" class="btn4"><b>스토어</b></a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/membership/membership_list.do" class="btn4"><b>멤버십</b></a>
			</li>
		</ul>
	</div>
</div>
<!-- 헤더 끝 -->
