<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div id="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
                <a href="eventList.do" title="이벤트 메인 페이지로 이동">이벤트</a>
				<a href="eventResultlist.do" title="당첨자발표 페이지로 이동">당첨자발표</a>
			</div>

		</div>
	</div>
	<div id="contents">
	    <div class="inner-wrap">
	        <h2 class="tit">당첨자발표</h2>
	        <div class="text-util">
	            <div class="left pt05">
	                <ul class="dot-list">
	                    <li>응모하신 이벤트의 당첨 여부는 나의 응모결과 확인을 통해  확인하실 수 있습니다.</li>
	                    <li>개인정보 처리방침에 따라 당첨자 발표일로 부터 6개월간 당첨자 발표내역을 확인할 수 있습니다.</li>
	                </ul>
	            </div>
	            <div class="right">
	                        <button type="button" class="button tooltip click">
	                            <span>나의 응모결과확인</span>
	                        </button>
	            </div>
	        </div>
	        <div class="board-list-util">
	            <p class="result-count"><strong>전체 <b>${count}</b>건</strong></p>
	            <div class="board-search">
	               <form action="eventResultList.do" style="border:none; padding:0;" >
						<input type="text" name="keyword" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
						<button type="submit" class="btn-search-input">검색</button>
					</form>
	            </div>
	        </div>
	
	        <div class="table-wrap">
	            <table class="board-list">
	                <caption>게시판 목록 제목</caption>
	                <colgroup>
	                    <col style="width:80px;" />
	                    <col style="width:130px;" />
	                    <col />
	                    <col style="width:100px;" />
	                    <col style="width:110px;" />
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th scope="col">번호</th>
	                        <th scope="col">분류</th>
	                        <th scope="col">이벤트명</th>
	                        <th scope="col">발표일</th>
	                        <th scope="col">당첨자발표</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="event" items="${list}">
		                    <tr>
		                       <td>${event.event_num}</td>
							   <td>${event.category_detail_name}</td>
							   <td><a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}">${event.title}</a></td>
							   <td>${event.event_end}</td>
							   <td>
									<c:if test="${event.state == 1}">
									<button onClick="location.href='eventResultDetail.do?event_num=${event.event_num}'">결과확인</button>
									</c:if>
									<c:if test="${event.state == 0}">
									대기중
									</c:if>
									<c:if test="${event.state == 0 && user.auth == 9 }">
									<button onclick="location.href='eventResultWrite.do?event_num=${event.event_num}'">결과작성</button>
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