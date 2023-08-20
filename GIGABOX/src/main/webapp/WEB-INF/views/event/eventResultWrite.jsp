<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="page-main">
<div class="event-detail">
            <h2>이벤트 결과</h2>
            <form action="eventResultWrite.do" method="post" style="width: 100%;border: none;">
            	<input type="hidden" name="event_num" value="${event_num}">
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
            <!-- 응모자 리스트 -->
             <div class="table-wrap">
	            <table class="board-list">
	                <caption>게시판 목록 제목</caption>
	                <colgroup>
	                    <col style="width:80px;" />
	                    <col style="width:100px;" />
	                    <col style="width:100px;" />
	                    <col style="width:130px;" />
	                    <col />
	                    <col style="width:80px;" />
	                </colgroup>
	                <thead>
	                    <tr>
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
        </div>
       </div>