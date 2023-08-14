<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../reservation/quick_res.do">예매</a> 
		<a href="../reservation/quick_res.do">빠른예매</a>
	</div>
</div>
<div class="page-main">
	<div class="title">
		빠른예매
	</div>
	<div class="seat-select-section">
			<input type="hidden" name="sch_num" value="${scheduleVO.sch_num}"/>
			<div class="seat-section">
				<div class="title-util">
					<h3>관람인원선택</h3>
				</div>
				<div class="seat-area">
					<div class="seat-count">
						<div class="cell">
							<p class="txt">인원</p>
							<div class="count">
								<input type="button" class="down" value="-">
								<input type="button" class="number" value="0">
								<input type="button" class="up" value="+">
							</div>
						</div>
					</div>
					<div class="seat-layout">
						<img src="${pageContext.request.contextPath}/images/스크린.png" style="position: absolute; left: 62px; top: 10px; width:83%;">
						<img src="${pageContext.request.contextPath}/images/우측출입구.png" style="position:absolute; left:561px; top:30px; width:20px; height: 20px;">
						<img src="${pageContext.request.contextPath}/images/좌측출입구.png" style="position:absolute; left:561px; top:270px; width:20px; height: 20px;">
						<div class="A">
							<input type="button" value="A1" data-num="A1" class="seat" style="left:181px;">
							<input type="button" value="A2" data-num="A2" class="seat" style="left:201px;">
							<input type="button" value="A3" data-num="A3" class="seat" style="left:221px;">
							<input type="button" value="A4" data-num="A4" class="seat" style="left:241px;">
							<input type="button" value="A5" data-num="A5" class="seat" style="left:261px;">
							<input type="button" value="A6" data-num="A6" class="seat" style="left:321px;">
							<input type="button" value="A7" data-num="A7" class="seat" style="left:341px;">
							<input type="button" value="A8" data-num="A8" class="seat" style="left:361px;">
							<input type="button" value="A9" data-num="A9" class="seat" style="left:381px;">
							<input type="button" value="A10" data-num="A10" class="seat" style="left:401px;">
							<input type="button" value="A11" data-num="A11" class="seat" style="left:461px;">
							<input type="button" value="A12" data-num="A12" class="seat" style="left:481px;">
							<input type="button" value="A13" data-num="A13" class="seat" style="left:501px;">
							<input type="button" value="A14" data-num="A14" class="seat" style="left:521px;">
							<input type="button" value="A15" data-num="A15" class="seat" style="left:541px;">
						</div>
						<div class="B">
							<input type="button" value="B1" data-num="B1" class="seat" style="left:181px;">
							<input type="button" value="B2" data-num="B2" class="seat" style="left:201px;">
							<input type="button" value="B3" data-num="B3" class="seat" style="left:221px;">
							<input type="button" value="B4" data-num="B4" class="seat" style="left:241px;">
							<input type="button" value="B5" data-num="B5" class="seat" style="left:261px;">
							<input type="button" value="B6" data-num="B6" class="seat" style="left:321px;">
							<input type="button" value="B7" data-num="B7" class="seat" style="left:341px;">
							<input type="button" value="B8" data-num="B8" class="seat" style="left:361px;">
							<input type="button" value="B9" data-num="B9" class="seat" style="left:381px;">
							<input type="button" value="B10" data-num="B10" class="seat" style="left:401px;">
							<input type="button" value="B11" data-num="B11" class="seat" style="left:461px;">
							<input type="button" value="B12" data-num="B12" class="seat" style="left:481px;">
							<input type="button" value="B13" data-num="B13" class="seat" style="left:501px;">
							<input type="button" value="B14" data-num="B14" class="seat" style="left:521px;">
							<input type="button" value="B15" data-num="B15" class="seat" style="left:541px;">
						</div>
						<div class="C">
							<input type="button" value="C1" data-num="C1" class="seat" style="left:181px;">
							<input type="button" value="C2" data-num="C2" class="seat" style="left:201px;">
							<input type="button" value="C3" data-num="C3" class="seat" style="left:221px;">
							<input type="button" value="C4" data-num="C4" class="seat" style="left:241px;">
							<input type="button" value="C5" data-num="C5" class="seat" style="left:261px;">
							<input type="button" value="C6" data-num="C6" class="seat" style="left:321px;">
							<input type="button" value="C7" data-num="C7" class="seat" style="left:341px;">
							<input type="button" value="C8" data-num="C8" class="seat" style="left:361px;">
							<input type="button" value="C9" data-num="C9" class="seat" style="left:381px;">
							<input type="button" value="C10" data-num="C10" class="seat" style="left:401px;">
							<input type="button" value="C11" data-num="C11" class="seat" style="left:461px;">
							<input type="button" value="C12" data-num="C12" class="seat" style="left:481px;">
							<input type="button" value="C13" data-num="C13" class="seat" style="left:501px;">
							<input type="button" value="C14" data-num="C14" class="seat" style="left:521px;">
							<input type="button" value="C15" data-num="C15" class="seat" style="left:541px;">
						</div>
						<div class="D">
							<input type="button" value="D1" data-num="D1" class="seat" style="left:181px;">
							<input type="button" value="D2" data-num="D2" class="seat" style="left:201px;">
							<input type="button" value="D3" data-num="D3" class="seat" style="left:221px;">
							<input type="button" value="D4" data-num="D4" class="seat" style="left:241px;">
							<input type="button" value="D5" data-num="D5" class="seat" style="left:261px;">
							<input type="button" value="D6" data-num="D6" class="seat" style="left:321px;">
							<input type="button" value="D7" data-num="D7" class="seat" style="left:341px;">
							<input type="button" value="D8" data-num="D8" class="seat" style="left:361px;">
							<input type="button" value="D9" data-num="D9" class="seat" style="left:381px;">
							<input type="button" value="D10" data-num="D10" class="seat" style="left:401px;">
							<input type="button" value="D11" data-num="D11" class="seat" style="left:461px;">
							<input type="button" value="D12" data-num="D12" class="seat" style="left:481px;">
							<input type="button" value="D13" data-num="D13" class="seat" style="left:501px;">
							<input type="button" value="D14" data-num="D14" class="seat" style="left:521px;">
							<input type="button" value="D15" data-num="D15" class="seat" style="left:541px;">
						</div>
						<div class="E">
							<input type="button" value="E1" data-num="E1" class="seat" style="left:181px;">
							<input type="button" value="E2" data-num="E2" class="seat" style="left:201px;">
							<input type="button" value="E3" data-num="E3" class="seat" style="left:221px;">
							<input type="button" value="E4" data-num="E4" class="seat" style="left:241px;">
							<input type="button" value="E5" data-num="E5" class="seat" style="left:261px;">
							<input type="button" value="E6" data-num="E6" class="seat" style="left:321px;">
							<input type="button" value="E7" data-num="E7" class="seat" style="left:341px;">
							<input type="button" value="E8" data-num="E8" class="seat" style="left:361px;">
							<input type="button" value="E9" data-num="E9" class="seat" style="left:381px;">
							<input type="button" value="E10" data-num="E10" class="seat" style="left:401px;">
							<input type="button" value="E11" data-num="E11" class="seat" style="left:461px;">
							<input type="button" value="E12" data-num="E12" class="seat" style="left:481px;">
							<input type="button" value="E13" data-num="E13" class="seat" style="left:501px;">
							<input type="button" value="E14" data-num="E14" class="seat" style="left:521px;">
							<input type="button" value="E15" data-num="E15" class="seat" style="left:541px;">
						</div>
						<div class="F">
							<input type="button" value="F1" data-num="F1" class="seat" style="left:181px;">
							<input type="button" value="F2" data-num="F2" class="seat" style="left:201px;">
							<input type="button" value="F3" data-num="F3" class="seat" style="left:221px;">
							<input type="button" value="F4" data-num="F4" class="seat" style="left:241px;">
							<input type="button" value="F5" data-num="F5" class="seat" style="left:261px;">
							<input type="button" value="F6" data-num="F6" class="seat" style="left:321px;">
							<input type="button" value="F7" data-num="F7" class="seat" style="left:341px;">
							<input type="button" value="F8" data-num="F8" class="seat" style="left:361px;">
							<input type="button" value="F9" data-num="F9" class="seat" style="left:381px;">
							<input type="button" value="F10" data-num="F10" class="seat" style="left:401px;">
							<input type="button" value="F11" data-num="F11" class="seat" style="left:461px;">
							<input type="button" value="F12" data-num="F12" class="seat" style="left:481px;">
							<input type="button" value="F13" data-num="F13" class="seat" style="left:501px;">
							<input type="button" value="F14" data-num="F14" class="seat" style="left:521px;">
							<input type="button" value="F15" data-num="F15" class="seat" style="left:541px;">
						</div>
						<div class="G">
							<input type="button" value="G1" data-num="G1" class="seat" style="left:181px;">
							<input type="button" value="G2" data-num="G2" class="seat" style="left:201px;">
							<input type="button" value="G3" data-num="G3" class="seat" style="left:221px;">
							<input type="button" value="G4" data-num="G4" class="seat" style="left:241px;">
							<input type="button" value="G5" data-num="G5" class="seat" style="left:261px;">
							<input type="button" value="G6" data-num="G6" class="seat" style="left:321px;">
							<input type="button" value="G7" data-num="G7" class="seat" style="left:341px;">
							<input type="button" value="G8" data-num="G8" class="seat" style="left:361px;">
							<input type="button" value="G9" data-num="G9" class="seat" style="left:381px;">
							<input type="button" value="G10" data-num="G10" class="seat" style="left:401px;">
							<input type="button" value="G11" data-num="G11" class="seat" style="left:461px;">
							<input type="button" value="G12" data-num="G12" class="seat" style="left:481px;">
							<input type="button" value="G13" data-num="G13" class="seat" style="left:501px;">
							<input type="button" value="G14" data-num="G14" class="seat" style="left:521px;">
							<input type="button" value="G15" data-num="G15" class="seat" style="left:541px;">
						</div>
						<div class="H">
							<input type="button" value="H1" data-num="H1" class="seat" style="left:181px;">
							<input type="button" value="H2" data-num="H2" class="seat" style="left:201px;">
							<input type="button" value="H3" data-num="H3" class="seat" style="left:221px;">
							<input type="button" value="H4" data-num="H4" class="seat" style="left:241px;">
							<input type="button" value="H5" data-num="H5" class="seat" style="left:261px;">
							<input type="button" value="H6" data-num="H6" class="seat" style="left:321px;">
							<input type="button" value="H7" data-num="H7" class="seat" style="left:341px;">
							<input type="button" value="H8" data-num="H8" class="seat" style="left:361px;">
							<input type="button" value="H9" data-num="H9" class="seat" style="left:381px;">
							<input type="button" value="H10" data-num="H10" class="seat" style="left:401px;">
							<input type="button" value="H11" data-num="H11" class="seat" style="left:461px;">
							<input type="button" value="H12" data-num="H12" class="seat" style="left:481px;">
							<input type="button" value="H13" data-num="H13" class="seat" style="left:501px;">
							<input type="button" value="H14" data-num="H14" class="seat" style="left:521px;">
							<input type="button" value="H15" data-num="H15" class="seat" style="left:541px;">
						</div>
						
					</div>
				</div>
			</div>
			<div class="seat-result">
				<div class="wrap">
					<div class="tit-area">
						<p class="tit">${scheduleVO.m_title}</p>
					</div>
					<div class="info-area">
						<p class="theater">${scheduleVO.th_name}</p>
						<p class="hall">${scheduleVO.hall_name}</p>
						<p class="date">${scheduleVO.sch_date}</p>
						<p class="time">${scheduleVO.sch_start} ~ ${scheduleVO.sch_end}</p>
						<p class="poster">
							<img src="${pageContext.request.contextPath}/images/no_image.jpg">
						</p>
					</div>
					<div class="choice-seat-area">
						<div class="legend">
							<ul class="list">
								<li>
									<img src="${pageContext.request.contextPath}/images/선택.png">
									<span>선택</span>
								</li>
								<li>
									<img src="${pageContext.request.contextPath}/images/예매완료.png">
									<span>예매완료</span>
								</li>
								<li>
									<img src="${pageContext.request.contextPath}/images/일반.png">
									<span>일반</span>
								</li>
							</ul>
						</div>
						<div class="seat-num">
							<div>선택좌석</div>
							<div class="my-seat">
								<p id="my_selected_seat1">-</p>
								<p id="my_selected_seat2">-</p>
								<p id="my_selected_seat3">-</p>
								<p id="my_selected_seat4">-</p>
								<p id="my_selected_seat5">-</p>
								<p id="my_selected_seat6">-</p>
								<p id="my_selected_seat7">-</p>
								<p id="my_selected_seat8">-</p>
							</div>
						</div>
					</div>
					<div class="pay-area">
						<p class="count">인원 <span class="person">0</span></p>
						<div class="tit">최종결제금액</div>
						<div class="money">
							<span id="money_area">0</span><span>원</span>
						</div>
					</div>
					<div id="btn_area">
						<input type="button" value="결제" id="pay">
					</div>
				</div>
			</div>
	</div>
	<br>
	<br>
</div>