<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
	</div>
</div>
<div class="page-main">
	<div class="title">
		<b>스토어</b>
	</div>    

	<div class='category_wrap'>
		<div class='category_contents_wrap'>
	    	<ul class='category_content'>
				<li><a href='#'>콤보</a></li>
				<li><a href='#'>팝콘</a></li>
				<li><a href='#'>음료</a></li>
				<li><a href='#'>스낵</a></li>
			</ul>
   			<ul class='cart_content'>
       			 <li><a href='#'>내 기프트콘</a><span id='giftconcnt'>0</span></li>
       			 <li><a href='#'>장바구니</a><span id='cartviewcnt'>0</span></li>
       		</ul>
		 </div>
	</div>




</div>