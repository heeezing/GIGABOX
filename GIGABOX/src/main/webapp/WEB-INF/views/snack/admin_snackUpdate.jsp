<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품 수정 폼 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/snack_update.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/snack.css">
<div class="page-main">
	<div class="title"><a href="admin_update.do?sn_num=${snackVO.sn_num}">상품 수정</a></div>
	<form:form modelAttribute="snackVO" action="admin_update.do" id="update_form" encType="multipart/form-data">
	<form:errors element="div" cssClass="error-color"/>
	<form:hidden path="sn_num"/>
		<!--[왼쪽] 사진 미리 보기 -->
		<div id="snack_photo">
			<img src="${pageContext.request.contextPath}/snack/photoView.do?sn_num=${snackVO.sn_num}" width="300" class="sn-photo">
			<div id="file_detail">
				(${snackVO.sn_photo_name})파일이 등록되어 있습니다.
			</div>			
		</div>
		<!--[오른쪽] 상품 정보 입력 -->
		<div id="snack_input">
			<ul>
				<li>
					<label>판매 여부</label>
					<input type="radio" name="sn_status" value="1" id="status1" <c:if test="${snackVO.sn_status == 1}">checked</c:if>>판매
					<input type="radio" name="sn_status" value="2" id="status2" <c:if test="${snackVO.sn_status == 2}">checked</c:if>>판매중지
				</li>
				<li>
					<label for="sn_name">상품명</label>
					<input type="text" name="sn_name" id="sn_name" maxlength="20" class="form-input" value="${snackVO.sn_name}">
				</li>
				<li>
					<label for="sn_detail">구성</label>
					<input type="text" name="sn_detail" id="sn_detail" maxlength="33" class="form-input" value="${snackVO.sn_detail}">
				</li>
				<li>
					<label for="sn_price">가격</label>
					<input type="number" name="sn_price" id="sn_price" min="0" max="999999" class="form-input"  value="${snackVO.sn_price}">
				</li>
				<li>
					<label for="sn_dc_price">할인가</label>
					<input type="number" name="sn_dc_price" id="sn_dc_price" min="0" max="999999" class="form-input" value="${snackVO.sn_dc_price}">
				</li>
				<li>
					<label for="sn_category">분류</label>
					<select name="sn_category" id="sn_category">
						<option value="1" <c:if test="${snackVO.sn_category==1}">selected</c:if>>콤보</option>
						<option value="2" <c:if test="${snackVO.sn_category==2}">selected</c:if>>팝콘</option>
						<option value="3" <c:if test="${snackVO.sn_category==3}">selected</c:if>>음료</option>
						<option value="4" <c:if test="${snackVO.sn_category==4}">selected</c:if>>스낵</option>
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
			<textarea rows="5" cols="60" name="sn_info" id="sn_info" class="form-text">${snackVO.sn_info}</textarea>
		</div>
		
		<div id="snack_button">
			<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/snack/admin_list.do'">
			<input type="submit" value="수정">
			<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
				 let delete_btn = document.getElementById('delete_btn');
				 //이벤트 연결
				 delete_btn.onclick=function(){
					 let choice = confirm('삭제하겠습니까?');
					 if(choice){
						 alert("상품 삭제가 완료되었습니다.");
						 //히스토리를 지우면서 이동
						 location.replace('admin_delete.do?sn_num=${snackVO.sn_num}');
					 }else{
						 return false;
					 }
				 };
				</script>
		</div>
	</form:form>
</div>
<!-- 상품 수정 폼 시작 끝 -->