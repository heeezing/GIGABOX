<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- MY페이지 메뉴 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div class="side-bar">
	<ul>
		<li>
			<img src="${pageContext.request.contextPath}/member/photoView.do" width="200" height="200" class="my-photo">
			<div class="camera" id="photo_btn">
				<img src="${pageContext.request.contextPath}/images/camera.png" width="35">
			</div>
		</li>
		<li>
			<div id="photo_choice" style="display:none;">
				<input type="file" id="upload" 
				    accept="image/gif,image/png,image/jpeg"><br>
				<input type="button" value="전송" id="photo_submit">
				<input type="button" value="취소" id="photo_reset">    
			</div>
		</li>
	</ul>
	 
	<ul>
		<li>
			<input type="button" class="menu-btn" value="예매 내역"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="구매 내역"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="포인트 내역"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="이벤트 응모 내역"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="문의 내역"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="나의 관람평"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="나의 무비포스트"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="회원정보"
			  onclick="location.href='${pageContext.request.contextPath}'">
		</li>
		<!-- 
		<li>
			<input type="button" class="menu-btn" value="회원탈퇴"
			  onclick="location.href='${pageContext.request.contextPath}/member/delete.do'">
		</li>
		 -->
	</ul>
</div>
<!-- MY페이지 메뉴 끝 -->





