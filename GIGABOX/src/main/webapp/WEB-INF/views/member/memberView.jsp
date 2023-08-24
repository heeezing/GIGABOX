<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<!-- my페이지 시작 -->
<script type="text/javascript">
	$(function(){
		$('#profilebtn').click(function(){
			$('.mypage-photo1').show();
		})
	});
</script>
<div class="page-main mypage-view">
	<h2>회원상세정보<input type="button" value="회원정보수정" onclick="location.href='update.do'" class="default-btn"></h2>
	<ul>
		<li>이름 : ${member.name}</li>
		<li>별명 : ${member.nick_name}</li>
		<li>전화번호 : ${member.phone}</li>
		<li>이메일 : ${member.email}</li>
		<li>우편번호 : ${member.zipcode}</li>
		<li>주소 : ${member.address1} ${member.address2}</li>
		<li>가입일 : ${member.reg_date}</li>
		<li>멤버십 등급 : ${membership}</li>
		<c:if test="${membership != 'BASIC'}">
		<input type="button" value="구독취소">
		</c:if>
	</ul>
	<br>
	<ul>
		<li>
			<input type="button" class="menu-btn1" value="비밀번호변경"
			  onclick="location.href='${pageContext.request.contextPath}/member/changePassword.do'">
		</li>
		<li>
			<input type="button" class="menu-btn1" value="회원탈퇴"
			  onclick="location.href='${pageContext.request.contextPath}/member/delete.do'">
		</li>
		<li>
			<input type="button" class="menu-btn1" value="프로필사진변경" id="profilebtn">
		</li>
		<li>
			<div class="mypage-photo1" style="display:none;">
				<ul>
				<li>
					<img src="${pageContext.request.contextPath}/member/photoView.do" width="100" height="100" class="my-photo">
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
			</div>
		</li>
		
	</ul>
</div>
<!-- my페이지 끝 -->