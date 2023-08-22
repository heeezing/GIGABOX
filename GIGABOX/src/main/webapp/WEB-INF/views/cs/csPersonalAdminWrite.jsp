<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="page-main">
	 <div class="page-main">
        <div class="event-detail">
            <h2 class="tit">${cs.title}</h2>
            <p class="event-detail-date">
                <span>작성일</span>
                <em> ${cs.reg_date}</em>
            </p>
            <div class="detail-info">
            ${cs.content}
            </div>
            <div> <!-- 첨부파일 시작 -->
            <c:forEach var="file" items="${files}">
            	<a href='<c:url value="/filedownload?file_num=${file.file_num}"/>'>${file.origin_name}(사이즈:${file.file_size }kb)</a>
            </c:forEach>
            </div><!-- 첨부파일 끝 -->
        </div>
        <div class="event-detail">
            <h2>문의 답변</h2>
            <form action="csPersonalAdminWrite.do" method="post" style="width: 100%;border: none;">
            	<input type="hidden" name="personal_num" value="${cs.personal_num }">
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
                                <th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
                                <td colspan="3">
                                    <div class="textarea">
                                        <textarea id="textarea" name="content" rows="5" cols="30" title="내용입력" class="input-textarea"></textarea>
                                        <div class="util">
                                            <p class="count">
                                                <span id="textareaCnt">0</span> / 2000
                                            </p>
                                        </div>
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
    
</div>