<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품 등록 폼 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/snack_insert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/snack.css">
<div class="page-main">
	<div class="title"><a href="admin_insert.do">상품 등록</a></div>
	<form:form modelAttribute="snackVO" action="admin_insert.do" id="insert_form" encType="multipart/form-data">
	<form:errors element="div" cssClass="error-color"/>
		<!--[왼쪽] 사진 미리 보기 -->
		<div id="snack_photo">
			<img src="${pageContext.request.contextPath}/images/no_image.jpg" width="300" class="sn-photo">
		</div>
		<!--[오른쪽] 상품 정보 입력 -->
		<div id="snack_input">
			<ul>
				<li>
					<label>판매 여부</label>
					<input type="radio" name="sn_status" value="1" id="status1" checked>판매
					<input type="radio" name="sn_status" value="2" id="status2">판매중지
				</li>
				<li>
					<label for="sn_name">상품명</label>
					<input type="text" name="sn_name" id="sn_name" maxlength="20" class="form-input">
				</li>
				<li>
					<label for="sn_detail">구성</label>
					<input type="text" name="sn_detail" id="sn_detail" maxlength="33" class="form-input">
				</li>
				<li>
					<label for="sn_price">가격</label>
					<input type="number" name="sn_price" id="sn_price" min="0" max="999999" class="form-input">
				</li>
				<li>
					<label for="sn_dc_price">할인가</label>
					<input type="number" name="sn_dc_price" id="sn_dc_price" min="0" max="999999" class="form-input">
				</li>
				<li>
					<label for="sn_category">분류</label>
					<select name="sn_category" id="sn_category">
						<option value="1">콤보</option>
						<option value="2">팝콘</option>
						<option value="3">음료</option>
						<option value="4">스낵</option>	
					</select>
				</li>
				<li>
					<label for="sn_photo" class="form-label">사진</label>
					<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg"><br>
				</li>
			</ul>
		</div>
		
		<div id="snack_text">
			<label for="sn_info">설명</label>
			<textarea rows="5" cols="60" name="sn_info" id="sn_info" class="form-text"></textarea>
		</div>
		
		<div id="snack_button">
			<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/snack/admin_list.do'">
			<input type="submit" value="등록">
		</div>
	</form:form>
</div>
<!-- 상품 등록 폼 시작 끝 -->