<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
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
<div class="page-main">
<div class="event-detail">
            <h2>이벤트 결과</h2>
            <form action="eventResultUpdate.do" method="post" style="width: 100%;border: none;">
            	<input type="hidden" name="result_num" value="${event.result_num}">
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
                                <td colspan="3"><input type="text" name="title" id="title" class="input-text" maxlength="100" value="${event.title}"/></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
                                    <div class="textarea">
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
                                    </div>
                                </td>
                            </tr>  
                        </tbody>
                    </table>
                </div>
                <div class="btn-group pt40">
                    <button type="submit" class="button purple large">답변 등록</button>
                </div>
            </form>
        </div>
       </div>