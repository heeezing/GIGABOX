<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location" style="margin-left:0;">
					<span>Home</span>
					<a href="/support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="/support/notice" title="공지사항 페이지로 이동">공지사항</a>
				</div>
			</div>
		</div>
		<div class="inner-wrap">
			<div class="lnb-area addchat">
				<nav id="lnb" class="ty2">
					<p class="tit">
						<a href="csMain.do" title="고객센터">고객센터</a>
					</p>
					<ul>
						<li><a href="csMain.do" title="고객센터 홈">고객센터
								홈</a></li>
						<li><a href="csQnaList.do" title="자주 묻는 질문">자주 묻는 질문</a></li>
						<li><a href="csNotiList.do" title="공지사항">공지사항</a></li>
						<li><a href="csPersonalWrite.do" title="1:1문의">1:1문의</a></li>
						<li><a href="#" title="이용약관">이용약관</a></li>
					</ul>
					<div class="left-customer-info">
						<p class="tit">
							메가박스 고객센터 <span>Dream center</span>
						</p>
						<p class="time">
							<i class="iconset ico-clock"></i> 10:00~19:00
						</p>
					</div>
				</nav>
			</div>

			<div id="contents">
				<h2 class="tit">공지사항</h2>

		
				<div class="board-list-util">
					<p class="result-count">전체 <em class="font-gblue">${count}</em>건</p>
					<!-- <form action="csNotiList.do" method="post" > -->
						<div class="board-search">
							<form method ="post" action="csNotiList.do" style="border:none; padding:0;">
							<input type="search" name="keyword" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" maxlength="15">
							<button type="submit" class="btn-search-input" id="searchBtn">검색</button>
						</form>
						</div>
					<!-- </form> -->	
				</div>

				<div class="table-wrap">
					<table class="board-list">
						<caption>번호, 극장, 구분, 제목, 등록일이 들어간 공지사항 전체 리스트</caption>
						<colgroup>
							<col style="width:72px;">
							<col style="width:133px;">
							<col style="width:95px;">
							<col>
							<col style="width:116px;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">극장</th>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${count == 0}">
								<tr>
									<td colspan="5">표시할 게시물이 없습니다.</div>
								</tr>
							</c:if>
							<c:if test="${count != 0}">						
								<c:forEach var="cs_noti" items="${list}">
									<tr>
										<td class="align-center">${cs_noti.noti_num}</td>
										<td class="align-center">${cs_noti.th_name}</td>
										<td class="align-center">공지</td>
										<td>
											<a href="csDetail.do?detail_num=${cs_noti.noti_num}&table=2">${cs_noti.title}</a>
										</td>
										<td class="align-center">${cs_noti.reg_date}</td>
									</tr>
								</c:forEach>
							</c:if>
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






