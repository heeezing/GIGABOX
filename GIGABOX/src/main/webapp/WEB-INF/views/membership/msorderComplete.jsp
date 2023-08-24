<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../membership/membership_list.do">멤버십</a>
	</div> 
</div>
<div class="page-main">
	
	<ul style="border-bottom:1px solid #000; padding:0;">
		<li class="no_data">
			<img src="${pageContext.request.contextPath}/images/orderComplete.png" width="50">
			<p style="font-size:20pt; margin:14px auto;">결제가 완료되었습니다.</p>
			<div class="btn_wrap" style="margin-top:60px;">
				<a href="${pageContext.request.contextPath}/main/main.do">메인페이지</a>
				<a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
			</div>
		</li>
	</ul>

</div>