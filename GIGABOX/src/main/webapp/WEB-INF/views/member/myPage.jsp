<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- myPage 시작 -->
<div class="mypage">
	<div class="mypage-top">
		<div class="mypage-membership"><b>Basic</b></div>
		<div class="mypage-hi">
			안녕하세요 !
			<p>${member.name}<span>님</span></p>
		</div>
		<div class="mypage-point">
			<b>포인트 : 0P</b><br>
			<a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포인트 내역></a>
		</div>
	</div>
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">나의 예매 내역</h2>
			<a href='${pageContext.request.contextPath}/board/memberReservation.do'>더보기></a>
		</div>
	</div>
	<div class="mypage-content">
		<ul>
			<li>예매 내역이 없습니다.</li>
		</ul>
	</div>
	<div class="tit-util mt70">
		<div>
			<h2 class="tit">나의 구매 내역</h2>
			<a href="${pageContext.request.contextPath}/board/memberAdd.do">더보기></a>
		</div>
	</div>
	<div class="mypage-content">
		<ul>
			<li>구매 내역이 없습니다.</li>
		</ul>
	</div>
	<div class="tit-util mt70">
		<div class="mypage-left">
			<div class="tit-util">
				<h2 class="tit">참여 이벤트</h2>
				<a href="${pageContext.request.contextPath}/board/memberEvent.do">더보기></a>
			</div>
			<div class="mypage-content">
				<ul>
					<li>참여 이벤트 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
		<div class="mypage-right">
			<div class="tit-util">
				<h2 class="tit">문의 내역</h2>
				<a href="${pageContext.request.contextPath}/board/memberQuestion.do">더보기></a>
			</div>
			<div class="mypage-content">
				<ul>
					<li>문의 내역이 없습니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- myPage 끝 -->