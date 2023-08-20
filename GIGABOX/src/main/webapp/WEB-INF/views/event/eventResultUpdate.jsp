<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
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
                                        <textarea id="textarea" name="content" rows="5" cols="30" title="내용입력" class="input-textarea">${event.content}</textarea>
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