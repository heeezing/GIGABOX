<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 스토어 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/snack.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
	</div>
</div>

<div class="page-main">
	<div class="title" style="font-size:30pt; margin-top:20px;" >
		<b>스토어</b>
	</div>    
	
	<hr size="3" noshade="noshade">
	
	<div class='category_wrap'>
		<div class='category_contents_wrap'>
	    	<ul class='category_content'>
				<li><a href='list.do' class="category-group <c:if test="${sn_category==0}">select</c:if>">전체</a></li>
				<li><a href='list.do?sn_category=1' class="category-group <c:if test="${sn_category==1}">select</c:if>">콤보</a></li>
				<li><a href='list.do?sn_category=2' class="category-group <c:if test="${sn_category==2}">select</c:if>">팝콘</a></li>
				<li><a href='list.do?sn_category=3' class="category-group <c:if test="${sn_category==3}">select</c:if>">음료</a></li>
				<li><a href='list.do?sn_category=4' class="category-group <c:if test="${sn_category==4}">select</c:if>">스낵</a></li>
			</ul>
			<ul></ul>
			<ul class='cart_content'>
       			<li><a href='${pageContext.request.contextPath}/board/giftList.do'>내 선물함</a><span id='giftconcnt'>0</span></li>
       			<li><a href='${pageContext.request.contextPath}/cart/list.do'>장바구니</a><span id='cartviewcnt'>${cartCount}</span></li>
       		</ul>
		 </div>
	</div>
	
	<hr size="1" noshade="noshade">
	
	<!-- 카테고리 멘트 시작 -->	
	<div class="category-title">
		<c:if test="${sn_category==0}">
		<b>전체</b>
		<span class="category-sub">기가박스의 풍부한 먹거리를 즐겨보세요</span>
		</c:if>
		<c:if test="${sn_category==1}">
		<b>콤보</b>
		<span class="category-sub">맛있으면 0칼로리, 아는 맛이 제일 맛있어요</span>
		</c:if>
		<c:if test="${sn_category==2}">
		<b>팝콘</b>
		<span class="category-sub">영화관에선 역시 팝콘! 안먹으면 서운해요</span>
		</c:if>
		<c:if test="${sn_category==3}">
		<b>음료</b>
		<span class="category-sub">탄산음료부터 에이드까지, 마시는 즐거움!</span>
		</c:if>
		<c:if test="${sn_category==4}">
		<b>스낵</b>
		<span class="category-sub">출출할땐 다양한 스낵이 정답이죠</span>
		</c:if>
	</div>
	<!-- 카테고리 멘트 끝 -->	
	
	<!-- 상품 목록 시작 -->
	<c:if test="${count == 0}">
		<div class="result-display">
			표시할 상품이 없습니다.
		</div>
	</c:if>
	
	<c:if test="${count > 0}">
	<div class="image-space">
		<c:forEach var="snack" items="${list}">
		<div class="horizontal-area">
			<a href="${pageContext.request.contextPath}/snack/detail.do?sn_num=${snack.sn_num}">
				<img src="imageView.do?sn_num=${snack.sn_num}">
				<span class="list-name"><b>${snack.sn_name}</b></span><br>
				<span class="list-detail">${snack.sn_detail}</span><br><br>
				<!-- 할인가가 있을 경우 -->
				<c:if test="${snack.sn_dc_price > 0}">
				<span class="list-price-red">
				<b><fmt:formatNumber value="${snack.sn_dc_price}"/>원</b>
				</span>
				<span class="list-dc-price">
				<fmt:formatNumber value="${snack.sn_price}"/>원
				</span>
				</c:if>
				<!-- 할인가가 없을 경우 -->
				<c:if test="${snack.sn_dc_price == 0 || snack.sn_dc_price == ''}">
				<span class="list-price">
				<b><fmt:formatNumber value="${snack.sn_price}"/>원</b>
				</span>
				</c:if>
			</a>
		</div>
		</c:forEach>
		<br>
		<hr width="100%" size="1" noshade="noshade" class="float-clear">
	</div>
	
	<div class="align-center" style="margin:30px 0 150px;">${page}</div>
	</c:if>
	<!-- 상품 목록 끝 -->

</div>
<!-- 스토어 목록 끝 -->