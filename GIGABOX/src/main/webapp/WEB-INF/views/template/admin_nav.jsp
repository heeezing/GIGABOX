<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<div class="side-bar">
	<ul>
		<li>
			<input type="button" class="menu-btn" value="회원 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="영화 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="극장 관리"
			  onclick="location.href='${pageContext.request.contextPath}/theater/theaterList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="상영관 관리"
			  onclick="location.href='${pageContext.request.contextPath}/hall/hallList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="상영시간표 관리"
			  onclick="location.href='${pageContext.request.contextPath}/reservation/admin_schedule.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="예매 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="스토어 관리"
			  onclick="location.href='${pageContext.request.contextPath}/snack/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="주문 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="포인트 내역"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="신고 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
			  <ul>
			  	<li><input type="button" class="menu-btn" value="관람평 신고 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'"></li>
			  	<li><input type="button" class="menu-btn" value="무비포스트 신고 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'"></li>
			  </ul>
		</li>
		<li>
			<input type="button" class="menu-btn" value="멤버십 관리"
			  onclick="location.href='${pageContext.request.contextPath}/membership/admin_membership_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="이벤트 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="고객센터"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
		</li>
	</ul>
</div>
<!-- Admin 메뉴 끝 -->





