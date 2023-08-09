<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
		<form action="res_pay.do" id="seat" method="post">
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
							<input type="button" value="A1" style="left:181px;">
							<input type="button" value="A2" style="left:201px;">
							<input type="button" value="A3" style="left:221px;">
							<input type="button" value="A4" style="left:241px;">
							<input type="button" value="A5" style="left:261px;">
							<input type="button" value="A6" style="left:321px;">
							<input type="button" value="A7" style="left:341px;">
							<input type="button" value="A8" style="left:361px;">
							<input type="button" value="A9" style="left:381px;">
							<input type="button" value="A10" style="left:401px;">
							<input type="button" value="A11" style="left:461px;">
							<input type="button" value="A12" style="left:481px;">
							<input type="button" value="A13" style="left:501px;">
							<input type="button" value="A14" style="left:521px;">
							<input type="button" value="A15" style="left:541px;">
						</div>
						<div class="B">
							<input type="button" value="B1" style="left:181px;">
							<input type="button" value="B2" style="left:201px;">
							<input type="button" value="B3" style="left:221px;">
							<input type="button" value="B4" style="left:241px;">
							<input type="button" value="B5" style="left:261px;">
							<input type="button" value="B6" style="left:321px;">
							<input type="button" value="B7" style="left:341px;">
							<input type="button" value="B8" style="left:361px;">
							<input type="button" value="B9" style="left:381px;">
							<input type="button" value="B10" style="left:401px;">
							<input type="button" value="B11" style="left:461px;">
							<input type="button" value="B12" style="left:481px;">
							<input type="button" value="B13" style="left:501px;">
							<input type="button" value="B14" style="left:521px;">
							<input type="button" value="B15" style="left:541px;">
						</div>
						<div class="C">
							<input type="button" value="C1" style="left:181px;">
							<input type="button" value="C2" style="left:201px;">
							<input type="button" value="C3" style="left:221px;">
							<input type="button" value="C4" style="left:241px;">
							<input type="button" value="C5" style="left:261px;">
							<input type="button" value="C6" style="left:321px;">
							<input type="button" value="C7" style="left:341px;">
							<input type="button" value="C8" style="left:361px;">
							<input type="button" value="C9" style="left:381px;">
							<input type="button" value="C10" style="left:401px;">
							<input type="button" value="C11" style="left:461px;">
							<input type="button" value="C12" style="left:481px;">
							<input type="button" value="C13" style="left:501px;">
							<input type="button" value="C14" style="left:521px;">
							<input type="button" value="C15" style="left:541px;">
						</div>
						<div class="D">
							<input type="button" value="D1" style="left:181px;">
							<input type="button" value="D2" style="left:201px;">
							<input type="button" value="D3" style="left:221px;">
							<input type="button" value="D4" style="left:241px;">
							<input type="button" value="D5" style="left:261px;">
							<input type="button" value="D6" style="left:321px;">
							<input type="button" value="D7" style="left:341px;">
							<input type="button" value="D8" style="left:361px;">
							<input type="button" value="D9" style="left:381px;">
							<input type="button" value="D10" style="left:401px;">
							<input type="button" value="D11" style="left:461px;">
							<input type="button" value="D12" style="left:481px;">
							<input type="button" value="D13" style="left:501px;">
							<input type="button" value="D14" style="left:521px;">
							<input type="button" value="D15" style="left:541px;">
						</div>
						<div class="E">
							<input type="button" value="E1" style="left:181px;">
							<input type="button" value="E2" style="left:201px;">
							<input type="button" value="E3" style="left:221px;">
							<input type="button" value="E4" style="left:241px;">
							<input type="button" value="E5" style="left:261px;">
							<input type="button" value="E6" style="left:321px;">
							<input type="button" value="E7" style="left:341px;">
							<input type="button" value="E8" style="left:361px;">
							<input type="button" value="E9" style="left:381px;">
							<input type="button" value="E10" style="left:401px;">
							<input type="button" value="E11" style="left:461px;">
							<input type="button" value="E12" style="left:481px;">
							<input type="button" value="E13" style="left:501px;">
							<input type="button" value="E14" style="left:521px;">
							<input type="button" value="E15" style="left:541px;">
						</div>
						<div class="F">
							<input type="button" value="F1" style="left:181px;">
							<input type="button" value="F2" style="left:201px;">
							<input type="button" value="F3" style="left:221px;">
							<input type="button" value="F4" style="left:241px;">
							<input type="button" value="F5" style="left:261px;">
							<input type="button" value="F6" style="left:321px;">
							<input type="button" value="F7" style="left:341px;">
							<input type="button" value="F8" style="left:361px;">
							<input type="button" value="F9" style="left:381px;">
							<input type="button" value="F10" style="left:401px;">
							<input type="button" value="F11" style="left:461px;">
							<input type="button" value="F12" style="left:481px;">
							<input type="button" value="F13" style="left:501px;">
							<input type="button" value="F14" style="left:521px;">
							<input type="button" value="F15" style="left:541px;">
						</div>
						<div class="G">
							<input type="button" value="G1" style="left:181px;">
							<input type="button" value="G2" style="left:201px;">
							<input type="button" value="G3" style="left:221px;">
							<input type="button" value="G4" style="left:241px;">
							<input type="button" value="G5" style="left:261px;">
							<input type="button" value="G6" style="left:321px;">
							<input type="button" value="G7" style="left:341px;">
							<input type="button" value="G8" style="left:361px;">
							<input type="button" value="G9" style="left:381px;">
							<input type="button" value="G10" style="left:401px;">
							<input type="button" value="G11" style="left:461px;">
							<input type="button" value="G12" style="left:481px;">
							<input type="button" value="G13" style="left:501px;">
							<input type="button" value="G14" style="left:521px;">
							<input type="button" value="G15" style="left:541px;">
						</div>
						<div class="H">
							<input type="button" value="H1" style="left:181px;">
							<input type="button" value="H2" style="left:201px;">
							<input type="button" value="H3" style="left:221px;">
							<input type="button" value="H4" style="left:241px;">
							<input type="button" value="H5" style="left:261px;">
							<input type="button" value="H6" style="left:321px;">
							<input type="button" value="H7" style="left:341px;">
							<input type="button" value="H8" style="left:361px;">
							<input type="button" value="H9" style="left:381px;">
							<input type="button" value="H10" style="left:401px;">
							<input type="button" value="H11" style="left:461px;">
							<input type="button" value="H12" style="left:481px;">
							<input type="button" value="H13" style="left:501px;">
							<input type="button" value="H14" style="left:521px;">
							<input type="button" value="H15" style="left:541px;">
						</div>
						
					</div>
				</div>
			</div>
			<div class="seat-result">
				<div class="wrap">
					<div class="tit-area">
						<p class="tit">영화제목</p>
					</div>
					<div class="info-area">
						<p class="theater">극장</p>
						<p class="hall">상영관</p>
						<p class="date">상영날짜</p>
						<p class="time">상영시간</p>
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
							<p class="tit">선택좌석</p>
							<div class="my-seat">
								<p>좌석</p>
								<p>좌석</p>
							</div>
						</div>
					</div>
					<div class="pay-area">
						<p class="count">인원 <span>2</span></p>
						<div class="pay">
							<p class="tit">최종결제금액</p>
							<div class="money">
								<span>15,000</span>원
							</div>
						</div>
					</div>
					<div class="btn-group">
					
					</div>
				</div>
			</div>
		</form>
	</div>
	<br>
	<br>
</div>