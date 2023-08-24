<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

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

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="page-main">
<div class="event-detail">
            <h2>이벤트 결과</h2>
            <form action="eventResultWrite.do" method="post" style="width: 100%;border: none;">
            	<input type="hidden" name="event_num" id="eventResult" value="${event_num}">
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
                                <td colspan="3"><input type="text" name="title" id="title" class="input-text" maxlength="100" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label>추첨 이벤트</label> <em class="font-orange">*</em></th>
                                <td colspan="3"><input type="text" name="" id="" class="input-text" maxlength="100" value="${eventName}" readonly/></td>
                            </tr>
                            <tr>
                            	 <th scope="row"><label >응모자 리스트</label><em class="font-orange">*</em></th>
                                <td colspan="3">
	                                <div class="table-wrap" id="random_result" style="overflow:scroll; height:200px; border:1px solid grey">
							            <table class="board-list">
							                <caption>게시판 목록 제목</caption>
							                <colgroup>
							                	<col style="width:80px;" />
							                    <col style="width:80px;" />
							                    <col style="width:100px;" />
							                    <col style="width:100px;" />
							                    <col style="width:130px;" />
							                    <col />
							                    <col style="width:80px;" />
							                </colgroup>
							                <thead>
							                    <tr>
							                    	<th scope="col"></th>
							                        <th scope="col">이름</th>
							                        <th scope="col">상영관</th>
							                        <th scope="col">전화번호</th>
							                        <th scope="col">이메일</th>
							                        <th scope="col">내용</th>
							                        <th scope="col">작성일</th>
							                    </tr>
							                </thead>
							                <tbody>
							               		 <c:if test="${fn:length(list) == 0}">
								                	<tr>
									                   <td colspan="6">이벤트 참가자가 없습니다.</td>
									                </tr>
							                	</c:if>
							                	<c:forEach var="reply" items="${list}">
							                	
								                    <tr>
								                       <td><input type="checkbox" class="event-reply-value" value="${reply.reply_num}"></td>
								                       <td>${reply.name}</td>
													   <td>${reply.th_name}</td>
													   <td>${reply.phone}</td>
													   <td>${reply.email}</td>
													   <td>${reply.content}</td>
													   <td>${reply.reg_date}</td>
								                    </tr>
							                	</c:forEach>
							                </tbody>
							            </table>
							        </div> 
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>추첨 방식</label> <em class="font-orange">*</em></th>
                                <td>
                                	<select name="method" id="method" style="width:100%;">
										<option value="" selected>추첨방식</option>
										<option value="1">무작위</option>
										<option value="2">선착순</option>
										<!--  <option value="3">영화관별 무작위</option>
										<option value="4">영화관별 선착순</option>-->
										<option value="5">직접 선택</option>
									</select>
                                </td>
                                <th scope="row"><label>추첨자 수 </label> <em class="font-orange">*</em></th>
                                <td>
                                	<input type="number" id="selectNum" class="input-text" maxlength="100" style="width:70%"/>
                                	<input type="button" id="clickBtn" class="button purple" value="추첨">
                                	<script type="text/javascript">
                                	$(function(){
                                		
                                		$('#clickBtn').click(function(){

                                	        //서버와 통신
                                	        $.ajax({
                                	            url:'../event/randomSelect.do',
                                	            type:'post',
                                	            data:{event_num: $('#eventResult').val(),method:$('#method').val(),selectNum:$('#selectNum').val()},
                                	            dataType:'json',
                                	            success:function(param){
                                						
                                	                $(param.list).each(function(index,item){
                                	               		alert(item.reply_num);
                                	        			$("#test").append(item.reply_num);
                                	                });	
                                					alert("작업 완");
                                	            },
                                	            error:function(){
                                	                alert('네트워크 오류 발생');
                                	            }

                                	        });
                                	    });
                                	});
                                	</script>
                                </td>
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
                <div id="test">
                </div>
            </form>
            <br>
            <!-- 응모자 리스트 -->           
        </div>
       </div>