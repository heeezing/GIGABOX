<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<!-- 게시판 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	 
	        $(".qut").on("click", function(){  
	            $(".qut").removeClass("on");
	            $(this).addClass("on");
	        });    
	  
	});
</script>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
					<span>Home</span>
					<a href="csMain.do" title="고객센터 페이지로 이동">고객센터</a>
					<a href="csQnaList.do" title="자주 묻는 질문 페이지로 이동">자주 묻는 질문</a>
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
				<h2 class="tit">자주 묻는 질문</h2>


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

					<div class="btn-area">
						
					</div>
				</div>
				<!--// input-search-area -->

				<div class="tab-block small mb30">
					<ul>
							<li><button type="button" class="btn tabBtn" title="전체" onclick="location.href='csQnaList.do'">전체</button></li>
							<li><button type="button" class="btn tabBtn" title="영화예매" onclick="location.href='csQnaList.do?category_num=1'">영화예매</button></li><!-- (14) -->
							<li><button type="button" class="btn tabBtn" title="할인혜택" onclick="location.href='csQnaList.do?category_num=2'" >할인혜택</button></li><!-- (3) -->
							<li><button type="button" class="btn tabBtn" title="결제수단/관람권" onclick="location.href='csQnaList.do?category_num=3'">결제수단/관람권</button></li><!-- (6) -->
							<li><button type="button" class="btn tabBtn" title="멤버십" onclick="location.href='csQnaList.do?category_num=4'">멤버십</button></li><!-- (13) -->
							<li><button type="button" class="btn tabBtn" title="VIP" onclick="location.href='csQnaList.do?category_num=5'">VIP</button></li><!-- (4) -->
							<li><button type="button" class="btn tabBtn" title="극장/특별관" onclick="location.href='csQnaList.do?category_num=6'">극장/특별관</button></li><!-- (8) -->
							<li><button type="button" class="btn tabBtn" title="스토어" onclick="location.href='csQnaList.do?category_num=7'">스토어</button></li><!-- (6) -->
							<li><button type="button" class="btn tabBtn" title="홈페이지/모바일" onclick="location.href='csQnaList.do?category_num=8'">홈페이지/모바일</button></li><!-- (11) -->
							<li><button type="button" class="btn tabBtn"  title="기프트카드" onclick="location.href='csQnaList.do?category_num=9'">기프트카드</button></li><!-- (12) -->
					</ul>
					<input type="hidden" id="bbsTotalCnt" value="77" />
				</div>
				 <div class="faq-list-box">
			        <p class="reset mb10">
			            <strong>
			                <span id="totalTitle">
			                전체
			                </span>
			                <span class="font-green" id="totalCnt">
			                ${count}
			                </span>
			                건
			            </strong>
			        </p>
			        <div class="faq-list">
			            <ul>
			                <ul>
			                <c:forEach var="cs_qna" items="${list}">
			                    <li>
			                        <div class="qut">
			                           <a>
			                                <p class="tit">
			                                    <span class="font-green">[${cs_qna.category_name}]</span>
			                                </p>
			                                <p class="txt">
			                                    <span>
			                                        ${cs_qna.title}
			                                    </span>
			                                </p>
			                            </a>
			                        </div>
			                        <div class="awn">
			                            <p class="cont">
			                                <span style="font-size:10.0pt">
			                                    <span style="line-height:107%">
			                                       <span>
			                                       		<br>${cs_qna.content}
			                                        </span>
			                                    </span>
			                                </span>
			                            </p>
			                        </div>
			                    </li>
			                </c:forEach>
			                </ul>
			            </ul>
			        </div>
			    </div>
				<!-- pagination -->
				<nav class="pagination">${page}</nav>
				<!--// pagination -->
			</div>
		</div>
	</div>
	<!--// container -->






