<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
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
				<h2 class="tit">고객센터 홈</h2>
				<!-- input-search-area -->
				<div class="input-search-area mb30">
					<div class="input-area">
						<label for="search01" class="label">빠른검색</label>

						<div class="board-search w460px">
							<input type="search" id="searchTxt" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" maxlength="15">
							<button type="button" class="btn-search-input" id="searchBtn">검색</button>
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

								<a href="support/faq.html" class="more" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml07"></i></a>
							</div>
							<div class="">
								<ol class="decimal-list">
									
										<li>
											<a href="#" class="faqBtn" data-idx="1" title="질문 상세보기">
												<span class="font-roboto">1</span>&nbsp;
												<span class="font-gblue">[기프트카드]</span> 기프트카드를 보냈는데 상대방이 받지 못한다고 합니다.
												<span class="date">2023.07.12</span>
											</a>
										</li>
								</ol>
							</div>
						</div>

						<div class="block right">
							<div class="tit-area">
								<h3 class="tit small">공지사항</h3>

								<a href="support/notice.html" class="more" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml07"></i></a>
							</div>

							<div class="decimal-list">
								<ol>
										<li>
											<a href="#" class="moveBtn" data-no="10936" title="공지사항 상세보기">
											<span class="font-gblue"><i class="iconset ico-notice"></i> [공지]</span>
												메가박스 위치기반서비스 이용 약관 변경 안내
											<span class="date">2023.08.14</span>
											</a>
										</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>