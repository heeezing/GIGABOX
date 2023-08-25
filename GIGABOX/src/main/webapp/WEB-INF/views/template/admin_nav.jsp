<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<div class="side-bar-area">
	<div class="side-bar">
		<p class="tit">
			<a>관리자 페이지</a>
		</p>
		<ul>
			<li>
				<a href="${pageContext.request.contextPath}/board/memberList.do" title="회원 관리">회원 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/movie/movieAdmin.do" title="영화 관리">영화 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/theater/theaterList.do" title="극장 관리">극장 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/hall/hallList.do" title="상영관 관리">상영관 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/reservation/admin_schedule.do" title="상영시간표 관리">상영시간표 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/reservation/admin_resList.do" title="예매 관리">예매 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/snack/admin_list.do" title="스토어 관리">스토어 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/order/admin_list.do" title="주문 관리">주문 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/point/admin_list.do" title="포인트 내역">포인트 내역</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/movie/reportAdmin.do" title="신고 관리">신고 관리</a>
				  <ul class="depth3">
				  	<li>
				  		<a href="${pageContext.request.contextPath}/movie/reportAdmin.do" title="관람평 신고 관리">관람평 신고 관리</a>
				  	</li>
				  </ul>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/membership/admin_membership_list.do" title="멤버십 관리">멤버십 관리</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/event/eventAdminList.do" title="이벤트 관리">이벤트 관리</a>
				<!--
				<ul class="depth3">
				  	<li>
				  		<a href="${pageContext.request.contextPath}/event/eventResultAdminList.do" title="추첨 이벤트 관리">추첨 이벤트 관리</a>
				  	</li>
				</ul>
				  -->
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/cs/csMain.do" title="고객센터">고객센터</a>
				<ul class="depth3">
					<li>
						<a href="${pageContext.request.contextPath}/cs/csQnaAdminList.do" title="자주묻는 질문 관리">자주묻는 질문 관리</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/cs/csNotiAdminList.do" title="공지사항 관리">공지사항 관리</a>
					</li>
				  	<li>
				  		<a href="${pageContext.request.contextPath}/cs/csPersonalList.do" title="1:1문의 관리">1:1문의 관리</a>
				  	</li>
				</ul>
			</li>
		</ul>
	</div>
</div>
<!-- Admin 메뉴 끝 -->





