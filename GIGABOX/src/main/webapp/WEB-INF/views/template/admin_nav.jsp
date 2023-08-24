<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<div class="side-bar">
	<ul>
		<li>
			<input type="button" class="menu-btn" value="회원 관리"
			  onclick="location.href='${pageContext.request.contextPath}/board/memberList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="영화 관리"
			  onclick="location.href='${pageContext.request.contextPath}/movie/movieAdmin.do'">
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
			  onclick="location.href='${pageContext.request.contextPath}/reservation/admin_resList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="스토어 관리"
			  onclick="location.href='${pageContext.request.contextPath}/snack/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="주문 관리"
			  onclick="location.href='${pageContext.request.contextPath}/order/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="포인트 내역"
			  onclick="location.href='${pageContext.request.contextPath}/point/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="신고 관리"
			  onclick="location.href='${pageContext.request.contextPath}/#'">
			  <ul>
			  	<li><input type="button" class="menu-btn" value="관람평 신고 관리"
			  onclick="location.href='${pageContext.request.contextPath}/movie/reportAdmin.do'"></li>
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
			  onclick="location.href='${pageContext.request.contextPath}/event/eventAdminList.do'">
			<ul>
			  	<li><input type="button" class="menu-btn" value="추첨 이벤트 관리"
			  onclick="location.href='${pageContext.request.contextPath}/event/eventResultAdminList.do'"></li>
			</ul>
		</li>
		<li>
			<input type="button" class="menu-btn" value="고객센터">
			<ul>
				<li><input type="button" class="menu-btn" value="자주묻는 질문 관리"
			  onclick="location.href='${pageContext.request.contextPath}/cs/csQnaAdminList.do'"></li>
				<li><input type="button" class="menu-btn" value="공지사항 관리"
			  onclick="location.href='${pageContext.request.contextPath}/cs/csNotiAdminList.do'"></li>
			  	<li><input type="button" class="menu-btn" value="1:1문의 관리"
			  onclick="location.href='${pageContext.request.contextPath}/cs/csPersonalList.do'"></li>
			</ul>
		</li>
	</ul>
</div>
<!-- Admin 메뉴 끝 -->





