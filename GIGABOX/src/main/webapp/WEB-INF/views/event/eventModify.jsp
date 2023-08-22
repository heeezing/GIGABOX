<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
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
	
	<form action="eventModify.do" method="post" enctype="multipart/form-data" style="width: 80%;border: none;">
		<input type="hidden" name="event_num" value="${event.event_num}">
	    <div class="table-wrap mt10">
                    <table class="board-form va-m">
                        <colgroup>
                            <col style="width:150px;">
                            <col> 
                            <col style="width:150px;">
                            <col> 
                        </colgroup>
                        <tbody>
                       		<tr>
                                <th scope="row"><label for="title">제목</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
	                                <select name="category_num">
										<option value="0" <c:if test="${event.category_num == 0}">selected</c:if>>이벤트 게시판</option>
										<option value="1" <c:if test="${event.category_num == 1}">selected</c:if>>진행중인 이벤트</option>
										<option value="2" <c:if test="${event.category_num == 2}">selected</c:if>>지난 이벤트</option>
										<option value="3" <c:if test="${event.category_num == 3}">selected</c:if>>당첨자 발표</option>
									</select>
									<select name="category_detail_num" >
										<option value="0" <c:if test="${event.category_detail_num == 0}">selected</c:if>>카테고리</option>
										<option value="1" <c:if test="${event.category_detail_num == 1}">selected</c:if>>기가PICK</option>
										<option value="2" <c:if test="${event.category_detail_num == 2}">selected</c:if>>영화</option>
										<option value="3" <c:if test="${event.category_detail_num == 3}">selected</c:if>>극장</option>
										<option value="4" <c:if test="${event.category_detail_num == 4}">selected</c:if>>시사회</option>
									</select>
									<select name="event_form_type" >
										<option value="0" <c:if test="${event.event_form_type == 0}">selected</c:if>>이벤트 타입</option>
										<option value="1" <c:if test="${event.event_form_type == 1}">selected</c:if>>기본 이벤트</option>
										<option value="2" <c:if test="${event.event_form_type == 2}">selected</c:if>>댓글 이벤트</option>
										<option value="3" <c:if test="${event.event_form_type == 3}">selected</c:if>>스탬프 이벤트</option>
									</select>
                                </td>
                            </tr>
                             <tr>
                                <th scope="row"><label >이벤트 시작일</label> <em class="font-orange">*</em></th>
                                <td><input type="date" name="event_start" value="${event.event_start}"/></td>
                                <th scope="row"><label >이벤트 종료일</label> <em class="font-orange">*</em></th>
                                <td><input type="date" name="event_end" value="${event.event_end}"/></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="title">제목</label> <em class="font-orange">*</em></th>
                                <td colspan="3"><input type="text" name="title" value="${event.title}" id="title" class="input-text" maxlength="100" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
                                    <div class="textarea">
                                        <!-- CK editor 시작 -->
		<textarea name="content" id="content">${event.content}</textarea>
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
                                       
                                    </div>
                                </td>
                            </tr>  
                            <tr>
                                <th scope="row"><label>썸네일</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
	                                <label>썸네일(1:1)</label>
									<input type="file" value="썸네일1" name="upload1">${event.thumb1_name}<br>
									<label>직사각형 썸네일(2:3)</label>
									<input type="file" value="썸네일2" name="upload2">${event.thumb2_name}<br>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
		<!-- 카테고리 선택 -->
		<div class="btn-group pt40">
            <button type="submit" class="button purple large">수정</button>
        </div>
	</form>
</div>
<!-- 이벤트 작성 폼 끝 -->