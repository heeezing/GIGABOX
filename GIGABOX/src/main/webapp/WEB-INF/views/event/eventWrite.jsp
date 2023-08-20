<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 이벤트 작성 폼 시작 -->
<!-- include libraries (jquery,bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div>
	<h2>eventWrite.do</h2>
	<h2>이벤트 작성폼</h2>
	<form action="eventWrite.do" method="post" enctype="multipart/form-data">
		<!-- 카테고리 선택 -->
		<select name="category_num">
			<option value="0" selected>이벤트 게시판</option>
			<option value="1">진행중인 이벤트</option>
			<option value="2">지난 이벤트</option>
			<option value="3">당첨자 발표</option>
		</select>
		<select name="category_detail_num" >
			<option value="0" selected>카테고리</option>
			<option value="1">기가PICK</option>
			<option value="2">영화</option>
			<option value="3">극장</option>
			<option value="4">시사회</option>
		</select>
		<select name="event_form_type" >
			<option value="0" selected>이벤트 타입</option>
			<option value="1">기본 이벤트</option>
			<option value="2">댓글 이벤트</option>
			<option value="3">스탬프 이벤트</option>
		</select>
		<input type="text" name="title"/>
		
		<label>이벤트 시작일</label>
		<input type="date" name="event_start"/>
		<b>~</b>
		<label>이벤트 종료일</label>
		<input type="date" name="event_end"/>
		<!-- CK editor 시작 -->
		<textarea name="content" id="content"></textarea>
			<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector('#content'),{
						           extraPlugins:[MyCustomUploadAdapterPlugin]
					             })
					             .then(editor => {
					            	 window.editor = editor;
					             })
					             .catch(error => {
					            	 console.error(error);
					             });
				</script>
		<!-- CK editor 끝 -->
		<div>
		<label>썸네일(1:1)</label>
		<input type="file" value="썸네일1" name="upload1"><br>
		<label>직사각형 썸네일(2:3)</label>
		<input type="file" value="썸네일2" name="upload2"><br>
		</div>
		<input type="submit" value="작성">
	</form>
</div>
<!-- 이벤트 작성 폼 끝 -->