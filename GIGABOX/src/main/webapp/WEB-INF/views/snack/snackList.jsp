<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.category_contents_wrap {
    display: flex;
}
.category_content {
    display: flex;
    justify-content: space-between;
    width: 100%;
    line-height: 26px;
    margin:0 20px 0 45px;
}
.cart_content {
    display: flex;
    align-items: center;
    line-height: 26px;
}
.category_content li, .cart_content li{
	font-size:14pt;
	display: inline-flex;
    align-items: center;
    font-weight:bold;
}
.cart_content li:first-child {
    padding-left: 42px;
}
.cart_content li{
	width:110px;
	margin:0 10px;
    display: inline-flex;
    align-items: center;
    padding-left: 14px;
}
.cart_content li a + span {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-left:8px;
    width: 20px;
    height: 20px;
    min-width: 12px;
    font-weight: 500;
    font-size: 13px;
    color: #fff;
    line-height: 20px;
    text-align: center;
    background-color: #fb4357;
    border-radius: 10px;
    outline: none;
}
.cart_content:before {
    content: '';
    display: inline-flex;
    width: 1px;
    height: 23px;
    background-color: #cfcfcf;
}
/*검색 양식 추가 (내비게이션 내부 검색)*/
.search-bar{
	height:26px;
	padding:7px;
}
.input-search{
	display:block;
	float:left;
	background-color:#FFFFFF;
	border:1px solid #CCCCCC;
	border-radius:15px 0 0 15px; /*상좌 상우 하우 하좌*/
	box-shadow:0 1px 1px rgba(0,0,0,0.05);
	width:120px;
	height:26px;
	padding:0 0 0 10px;
	font-size:12px;
	color:#555555;
}
.input-search:focus{ /*검색 바 클릭했을 때 설정*/
	border-color:rgba(82,168,236,0.8);
	/*border 바깥 외곽선 설정*/
	outline:0; /*0 입력으로 외곽선이 추가로 생기지 않게 설정*/
	box-shadow:0 1px 1px rgba(0,0,0,0.05);
}
.input-search-submit{
	width:50px;
	height:26px;
	border-radius:0 15px 15px 0; /*상좌 상우 하우 하좌*/
	border:1px solid #CCCCCC;
	margin-left:-1px; /*음수 입력으로 여백 줄이기*/
	cursor:pointer;
}
.image-space{
	margin: 57px 0 20px 20px;
}
.image-space .horizontal-area{
	margin:15px 15px 45px 15px;
	padding:3px;
	width:350px;
	height:480px;
	float:left;
	text-align:center;
	overflow:hidden;
}
.image-space .horizontal-area img{
	width:350px;
	height:350px;	
	margin-bottom:20px;
}
.image-space .horizontal-area img:hover{
	border:1px solid #703691;
}
.image-space span{
	padding:10px 0;
}
.image-space .float-clear{
	clear:both;
}
.list-name, .list-price{
	font-size:14pt;
}
.list-detail{
	color:gray;
}
.category-title{
	display: block;
    padding-bottom: 13px;
    font-weight: 500;
    font-size: 28px;
    color: #000;
    border-bottom: 1px solid #999;
    margin-top:70px;
}
.category-title span {
    font-weight: 300;
    font-size: 20px;
    padding-left: 11px;
}
.select{
	color:red !important;
}
</style>
<!-- 스토어 목록 시작 -->
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
				<li><a href='list.do?sn_category=1' class="category-group <c:if test="${sn_category==1}">select</c:if>">콤보</a></li>
				<li><a href='list.do?sn_category=2' class="category-group <c:if test="${sn_category==2}">select</c:if>">팝콘</a></li>
				<li><a href='list.do?sn_category=3' class="category-group <c:if test="${sn_category==3}">select</c:if>">음료</a></li>
				<li><a href='list.do?sn_category=4' class="category-group <c:if test="${sn_category==4}">select</c:if>">스낵</a></li>
			</ul>
			<ul></ul>
			<ul class='cart_content'>
       			<li><a href='#'>내 선물함</a><span id='giftconcnt'>0</span></li>
       			<li><a href='#'>장바구니</a><span id='cartviewcnt'>0</span></li>
       		</ul>
		 </div>
	</div>
	
	<hr size="1" noshade="noshade">
	
	<!-- 검색창 
	<div class="search-bar" style="float:right;">
	<form action="list.do" id="search_form" method="get">
		<ul class="search" style="width:170px;">
			<li>
				<input type="search" class="input-search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색" class="input-search-submit">
			</li>
		</ul>
	</form>
	</div>
	-->
	
	<!-- 상품 목록 시작 -->
	<div class="category-title">
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
				<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${snack.sn_num}&sn_type=1">
				<span class="list-name"><b>${snack.sn_name}</b></span><br>
				<span class="list-detail">${snack.sn_detail}</span><br><br>
				<span class="list-price"><b><fmt:formatNumber value="${snack.sn_price}"/>원</b></span>
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