<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<!-- include libraries(jquery,bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline{
	min-height: 250px;
}
</style>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include CKeditor -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

</head>
<body>
<div>
	
	<form action="csModify.do" method="post" style="width: 80%;border: none;">
		<input type="hidden" name="noti_num" value=${cs.noti_num}>
		<input type="hidden" name="qna_num" value=${cs.qna_num}>
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
                                <th scope="row"><label for="title">옵션</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
	                               <select name="table" id="table"  >
										<option value="0" <c:if test="${table == 0}">selected</c:if>>공지사항 게시판</option>
										<option value="1" <c:if test="${table == 1}">selected</c:if>>자주 묻는 질문</option>
										<option value="2" <c:if test="${table == 2}">selected</c:if>>공지사항</option>
									</select>
									<c:if test="${cs.category_num != 0 && cs.category_num != ''}">
										<select name="category_num" id="category_num">
											<option value="0">-카테고리-<option>
											<c:forEach var="cate" items="${category}">
												<option value="${cate.category_num}" <c:if test="${cate.category_num == cs.category_num}">selected</c:if>>${cate.category_name}</option>
											</c:forEach>
										</select>
									</c:if>
								
									<c:if test="${cs.th_num != 0 && cs.th_num != ''}">
									<select name="th_num" id="th_num">
										<option value="0">-영화관-</option>
										<c:forEach var="th" items="${theater}">
											<option value="${th.th_num}" <c:if test="${th.th_num == cs.th_num}">selected</c:if>>${th.th_name}</option>
										</c:forEach>
									</select>
									</c:if>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="title">제목</label> <em class="font-orange">*</em></th>
                                <td colspan="3"><input type="text" name="title" value="${cs.title}" id="title" class="input-text" maxlength="100" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
                                    <div class="textarea">
                                        <!-- CK editor 시작 -->
		<textarea name="content" id="content">${cs.content}</textarea>
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
                        </tbody>
                    </table>
                </div>
		<!-- 카테고리 선택 -->
		<div class="btn-group pt40">
            <button type="submit" class="button purple large">수정</button>
        </div>
	</form>

</div>
<script type="text/javascript">
$(function(){
	$('#table').click(function(){
		if($('#table').val()=="1"){//자주 묻는 질문
			$('#th_num').attr('style', 'display:none');
			$('#category_num').attr('style', 'display:content');
			$('#category_num').removeAttr('disabled');
		}else if($('#table').val()=="2"){//자주 묻는 질문
			$('#category_num').attr('style', 'display:none');
			$('#th_num').attr('style', 'display:content');
			$('#th_num').removeAttr('disabled');
		}else{
			$('#th_num').attr('style', 'display:content');
			$('#category_num').attr('style', 'display:content');
			$('#th_num').attr('disabled','true');
			$('#category_num').attr('disabled','true');
		}
	});
	
});
</script>

