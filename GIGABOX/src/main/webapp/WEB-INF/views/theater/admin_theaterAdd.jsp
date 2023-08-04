<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/theater.js"></script>
<!-- 극장 등록 시작 -->
<div class="page-main">
	<div class="title">
		극장등록
	</div>
	<form action="theaterAdd.do" id="theater_add" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for="th_name">극장명</label>
				<input type="text" name="th_name" id="th_name" maxlength="50" width="200">
			</li>
			<li>
				<label for="th_address">주소</label>
				<input type="text" name="th_address" id="th_address" maxlength="200" width="200">
			</li>
			<li>
				<label for="th_phone">전화번호</label>
				<input type="text" name="th_phone" id="th_phone" maxlength="50" width="200">
			</li>
			<li>
				<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg"><br>
			</li>
			<li>
				<img src="${pageContext.request.contextPath}/theater/photoView.do" width="200" height="200" class="th-photo">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록" class="button">
			<input type="button" value="목록" class="dafault-btn" onclick="location.href='${pageContext.request.contextPath}/theater/theaterList.do'">
		</div>
	</form>
</div>
<!-- 극장 등록 끝 -->