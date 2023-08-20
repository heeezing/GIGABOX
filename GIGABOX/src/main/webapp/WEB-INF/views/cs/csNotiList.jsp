<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
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
						<li class="on"><a href="csMain.do" title="고객센터 홈">고객센터
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

				<div class="tab-block mb30">
					<ul>
						<li class="on tabBtn"><button type="button" class="btn tabBtn" data-no="" title="전체공지 보기">전체</button></li>
						<li class="tabBtn"><button type="button" class="btn" data-no="81" title="메가박스 공지 보기" >메가박스 공지</button></li>
						<li class="tabBtn"><button type="button" class="btn" data-no="82" title="지점 공지 보기" >지점 공지</button></li>
					</ul>
				</div>
				<div class="board-list-util">
					<p class="result-count">전체 <em class="font-gblue">0</em>건</p>
					<select id="theater02" name="th_num" title="극장 선택" class="mr07">
						<option value="">극장 선택</option>
						<c:forEach var="th" items="${theater}">
							<option value="${th.th_num}">${th.th_name}</option>
						</c:forEach>
					</select>
					<div class="board-search">
						<input type="text" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
						<button type="button" id="searchBtn" class="btn-search-input">검색</button>
					</div>
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
						<tbody></tbody>
					</table>
				</div>

				<!-- pagination -->
				<nav class="pagination"></nav>
				<!--// pagination -->
			</div>
		</div>
	</div>
	<!--// container -->
<!-- 		</div> -->
        

<!-- 게시판 목록 시작 -->
<div class="page-main">
	<h2>게시판 목록</h2>
	<form action="csNotiList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="theater" id="theater">
					<c:forEach var="th" items="${theater}">
						<option value="${th.th_num}">${th.th_name}</option>
					</c:forEach>
				</select>
			</li>
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='csNotiList.do'">
			</li>
		</ul>
		<div class="align-right">
			<c:if test="${!empty user}">
				<input type="button" value="글쓰기" 
			                     onclick="location.href='csWrite.do'">
			</c:if>
		</div>
		<div>
		<table>
		<tr>
			<td>전체</td>
			<td>기가박스 공지</td>
			<td>지점 공지</td>
		</tr>
		</table>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>			
			<th>극장</th>
			<th>구분</th>
			<th>제목</th>
			<th>등록일</th>
		</tr>
		<c:forEach var="cs_noti" items="${list}">
		<tr>
			<td class="align-center">${cs_noti.noti_num}</td>
			<td class="align-center">${cs_noti.th_name}</td>
			<td class="align-center">공지</td>
			<td>
				<a href="detail.do?board_num=${cs_noti.noti_num}">${cs_noti.title}</a>
			</td>
			<td class="align-center">${cs_noti.reg_date}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 게시판 목록 끝 -->




