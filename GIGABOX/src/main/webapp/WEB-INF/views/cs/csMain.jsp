<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location" style="margin-left:0;">
					<span>Home</span>
					<a href="csMain.do" title="고객센터 페이지로 이동">고객센터</a>
					<a href="csMain.do" title="고객센터 페이지로 이동">고객센터 홈</a>
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
				<h2 class="tit">고객센터 홈</h2>
				<!-- input-search-area -->
				<div class="input-search-area mb30">
					<div class="input-area">
						<label for="search01" class="label">빠른검색</label>

						<div class="board-search w460px">
						<form method ="post" action="csQnaList.do" style="border:none; padding:0;">
							<input type="search" name="keyword" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" maxlength="15">
							<button type="submit" class="btn-search-input" id="searchBtn">검색</button>
						</form>
						</div>
					</div>
				</div>

				<div class="custo-main">
					<div class="main-block">	
						
						<div class="block-content">
							<a href="csPersonalWrite.do" title="1:1 문의 페이지로 이동">
								<p>
									<strong>1:1 문의</strong>
									해결되지않은 문제가 있나요?<br />1:1문의로 문의주세요
								</p>
							</a>
						</div>
						
						<div class="block-content">
							<a href="csQnaList.do" title="자주 묻는 질문 페이지로 이동">
								<p>
									<strong>자주 묻는 질문</strong>
									자주 묻는 질문<br/>빠르고 간편하게 검색하세요.
								</p>
							</a>
						</div>
							<div class="block-content">
							<a href="csNotiList.do" title="공지사항 페이지로 이동">
								<p>
									<strong>공지사항</strong>
									공지사항을 <br />보기 쉽게 정렬하였습니다.
								</p>
							</a>
						</div>
					</div>
					
					<div class="notice-wrap">
						<div class="block left">
							<div class="tit-area">
								<h3 class="tit small">자주 묻는 질문 BEST5</h3>

								<a href="csQnaList.do" class="more" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml07"></i></a>
							</div>
							<div class="">
								<ol class="decimal-list">
									<c:forEach var="qna" items="${qna}">
										<li>
											<a href="csQnaList.do" class="faqBtn" data-idx="1" title="질문 상세보기">
												<span class="font-gblue">[${qna.category_name}]</span> ${qna.title}
												<span class="date">${qna.reg_date}</span>
											</a>
										</li>
									</c:forEach>
								</ol>
							</div>
						</div>

						<div class="block right">
							<div class="tit-area">
								<h3 class="tit small">공지사항</h3>

								<a href="csNotiList.do" class="more" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml07"></i></a>
							</div>

							<div class="decimal-list">
								<ol>
									<c:forEach var="noti" items="${noti}">
										<li>
											<a href="csDetail.do?detail_num=${noti.noti_num}&table=2" class="moveBtn" data-no="10936" title="공지사항 상세보기">
											<span class="font-gblue"><i class="iconset ico-notice"></i> [공지]</span>
												${noti.title}
											<span class="date">${noti.reg_date}</span>
											</a>
										</li>
									</c:forEach>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>