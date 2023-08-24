<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/event_page.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
<div class="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
                <a href="eventList.do" title="이벤트 메인 페이지로 이동">이벤트</a>
                <a href="eventEndList.do" title="지난 이벤트 페이지로 이동">지난 이벤트</a>
			</div>
		</div>
	</div>
	<div class="inner-wrap">
		<h2 class="tit">지난 이벤트</h2>
		<ul class="dot-list">
			<li>
				응모하신 이벤트의 당첨 여부는 당첨자발표의
				<button type="button" class="reset tooltip click">
				<strong class="font-gblue">나의 응모결과 확인</strong>
				</button>
				을 통해  확인하실 수 있습니다.
			</li>	
		</ul>		
	</div>
	<div id="contents" class="">
	    <div id="boardSearch" class="inner-wrap" style="">
	            <div class="board-list-util mt0">
	            <p class="result-count"><strong>전체 <b id="count_number"> </b>건</strong></p>
	
	            <div class="board-search">
	                <input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
	                <button type="button" class="btn-search-input">검색</button>
	            </div>
	        </div>
	    </div>
	    <div id="event-list-wrap">
	        <div class="inner-wrap">
	                <div class="event-list finish ">
	                    <ul id="output">
	                        
	                    </ul>
	                </div>
	        </div>
	    </div>
	    <div class="btn-more v1 paging-button" style="">
	        <button type="button" class="btn">더보기 <i class="iconset ico-btn-more-arr"></i></button>
	    </div>
	</div>
</div>
<!-- 아래부터 내가 작성 -->