<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div id="container">
        <div class="page-util">
            <div class="inner-wrap">
            <!-- 
                <div class="location">
                    <span>Home</span>
                    <a href="eventList.do" title="이벤트 메인 페이지로 이동">이벤트</a>
                    <a href="eventResultlist.do" title="당첨자발표 페이지로 이동">당첨자발표</a>
                </div>
             -->
            </div>
        </div>
        <div id="contents">
            <div class="inner-wrap">
                </div>
                <div class="board-list-util">
                    <p class="result-count"><strong>전체 <b>${count}</b>건</strong></p>
                    <div class="board-search">
                        <input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
                        <button type="button" class="btn-search-input">검색</button>
                    </div>
                </div>
        
                <div class="table-wrap">
                    <table class="board-list">
                        <caption>게시판 목록 제목</caption>
                        <colgroup>
                            <col style="width:80px;" />
                            <col style="width:130px;" />
                            <col style="width:100px;" />
                            <col />
                            <col style="width:100px;" />
                            <col style="width:110px;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">문의대상</th>
                                <th scope="col">문의유형</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성일</th>
                                <th scope="col">답변상태</th>
                            </tr>
                        </thead>
                        <tbody>
                              <c:forEach var="cs" items="${list}">
                                <tr>
                                   <td>${cs.rnum}</td>
                                   <td>
                                   <c:if test="${cs.th_num != 101}">
                                   ${cs.th_name}
                                   </c:if>
                                   <c:if test="${cs.th_num == 101}">
                                   고객센터
                                   </c:if>
                                   </td>
                                   <td>${cs.category_name}</td>
                                   <td><a href="csPersonalDetail.do?personal_num=${cs.personal_num}">${cs.title}</a></td>
                                   <td>
                                   <c:if test="${cs.modify_date eq null || cs.modify_date == ''}">
                                   	${cs.reg_date}
                                   </c:if>
                                    <c:if test="${cs.modify_date != ''}">
                                   	${cs.modify_date}
                                   </c:if>
                                   </td>
                                   <td>
                                   <c:if test="${cs.state==1}">
                                  	답변완료
                                   </c:if>
                                   <c:if test="${cs.state==0}">
                                   <button onclick="location.href='csPersonalAdminWrite.do?personal_num=${cs.personal_num}'">답변하기</button>
                                   </c:if>
                                   </td>
                                </tr>
                                 </c:forEach>
    
                        </tbody>
                    </table>
                </div>
                <!-- pagination -->
                <nav class="pagination">${page}</nav>
                <!--// pagination -->
            </div>
        </div>
    </div>
<!--// container -->