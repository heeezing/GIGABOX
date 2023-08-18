<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 주문 시작 -->
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/store.order.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.order.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../snack/list.do">스토어</a> 
		<a href="#">주문</a> 
	</div>
</div>
<div class="page-main">
	<!-- 주문 단계 UI 표시 -->
	<div class="cart_step_wrap">
		<ul class="cart_step">
			<li class="step1">
				<i class="bi bi-cart3"></i>
				<span style="float:right;"><b>STEP 01<br>장바구니</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step2 active">
				<i class="bi bi-pencil-square"></i>
				<span style="float:right;"><b>STEP 02<br>주문 정보</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step3 ">
				<i class="bi bi-credit-card"></i>
				<span style="float:right;"><b>STEP 03<br>결제하기</b></span>
			</li>
			<li class="arrow"><img src="${pageContext.request.contextPath}/images/arrow.png"></li>
			<li class="step4">
				<i class="bi bi-check-circle"></i>
				<span style="float:right;"><b>STEP 04<br>결제 완료</b></span>
			</li>
		</ul>
	</div>
	
	<!-- 구매 상품 정보 -->
	<strong class="com_box_design_title">구매상품 정보</strong>
	<form:form modelAttribute="orderVO" action="order.do" id="order_register" name="order_register">
	<input type="hidden" name="orders_num" value="${orders_num}" id="orders_num">
	<input type="hidden" name="email" value="${member.email}" id="email">
	<input type="hidden" name="zipcode" value="${member.zipcode}" id="zipcode">
	<input type="hidden" name="address1" value="${member.address1}" id="address1">
	<input type="hidden" name="orders_type" value="${orders_type}" id="orders_type">
	<input type="hidden" name="origin_total" value="${origin_total}">
		<table class="cart-table">
			<thead>
			<tr>
				<th>상품명</th>
				<th>판매금액</th>
				<th>수량</th>
				<th>구매금액</th>
			</tr>
			</thead>
			
			<tbody>
			
			<c:choose>
				<c:when test="${singleProduct}">
				<input type="hidden" name="isDirectOrder" value="true">
				<input type="hidden" name="sn_num" value="${snack.sn_num}">
				<input type="hidden" name="sn_name" value="${snack.sn_name}" id="sn_name">
				<input type="hidden" name="orders_quantity" value="${orders_quantity}" id="orders_quantity">
				<input type="hidden" name="orders_type" value="1"> 
				<tr>
					<!-- (1)상품명 -->
					<td>
						<span class="product-img">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${snack.sn_num}">
						<strong class="product-name">${snack.sn_name}</strong>
						<span class="product-detail">${snack.sn_detail}</span>
						</span>
					</td>
					<!-- (2)판매금액 -->
					<td class="align-center">
						<!-- 할인가가 있을 경우 -->
						<c:if test="${snack.sn_dc_price > 0}">
						<span>
							<fmt:formatNumber value="${snack.sn_dc_price}"/>원
						</span><br>
						<span class="origin-price">
							<fmt:formatNumber value="${snack.sn_price}"/>원
						</span>
						</c:if>
						<!-- 할인가가 없을 경우 -->
						<c:if test="${snack.sn_dc_price == 0 || snack.sn_dc_price == ''}">
						<span>
							<fmt:formatNumber value="${snack.sn_price}"/>원
						</span>
						</c:if>
					</td>
					<!-- (3)구매수량 -->
					<td class="align-center">
						<fmt:formatNumber value="${orders_quantity}"/>개
					</td>
					<!-- (4)구매금액 --> 
					<td class="align-center">
						<div class="sub-total" data-total="${all_total}">
							<fmt:formatNumber value="${all_total}"/>원
						</div>
					</td>
				</tr>
				</c:when>

	            <c:otherwise>
				<c:forEach var="cart" items="${list}">
				<input type="hidden" name="cart_numbers" value="${cart.cart_num}">
				<input type="hidden" name="isDirectOrder" value="false">
				<input type="hidden" name="orders_type" value="1">
				<input type="hidden" name="sn_name" value="${sn_name}" id="sn_name">

				<tr>
					<!-- (1)상품명 -->
					<td>
						<span class="product-img">
						<img src="${pageContext.request.contextPath}/snack/imageView.do?sn_num=${cart.sn_num}">
						<strong class="product-name">${cart.snackVO.sn_name}</strong>
						<span class="product-detail">${cart.snackVO.sn_detail}</span>
						</span>
					</td>
					<!-- (2)판매금액 -->
					<td class="align-center">
						<!-- 할인가가 있을 경우 -->
						<c:if test="${cart.snackVO.sn_dc_price > 0}">
						<span>
							<fmt:formatNumber value="${cart.snackVO.sn_dc_price}"/>원
						</span><br>
						<span class="origin-price">
							<fmt:formatNumber value="${cart.snackVO.sn_price}"/>원
						</span>
						</c:if>
						<!-- 할인가가 없을 경우 -->
						<c:if test="${cart.snackVO.sn_dc_price == 0 || cart.snackVO.sn_dc_price == ''}">
						<span>
							<fmt:formatNumber value="${cart.snackVO.sn_price}"/>원
						</span>
						</c:if>
					</td>
					<!-- (3)구매수량 -->
					<td class="align-center">
						<fmt:formatNumber value="${cart.orders_quantity}"/>개
					</td>
					<!-- (4)구매금액 --> 
					<td class="align-center">
						<div class="sub-total" data-total="${cart.sub_total}">
							<fmt:formatNumber value="${cart.sub_total}"/>원
						</div>
					</td>
				</tr>
				</c:forEach>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>

		<!-- [주문] 주문자 정보 -->
		<c:if test="${orders_type == 1}">
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">주문자 정보</strong>
	       <ul class="com_box_design">
	           <li>
	               <label for="name">이름</label>
	               <input type="text" id="name" style="width: 128px" value="${member.name}" readonly>
	               
	               <label for="phone">전화번호</label>
	               <input type="text" id="phone" style="width: 228px" value="${member.phone}" readonly>
	           </li>
	       </ul>
	       <p class="com_box_design_olist">
	           * 주문자 정보는 '마이페이지 > 회원정보 수정'에서 가능합니다.
	       </p>
	  	</div>
	  	</c:if>
	  	
		<!-- [선물] 받는 사람 정보 -->
		<c:if test="${orders_type == 2}">
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">선물 받는 분 정보</strong>
		<span id="searchResult"></span>
	       <ul class="com_box_design">
	           <li>
	               <label for="to_id">아이디</label>
	               <input type="text" id="to_id" name="to_id" style="width:228px" maxlength="33">
	               
	               <label for="to_phone">전화번호</label>
	               <input type="tel" id="to_phone" name="to_phone" style="width:228px" maxlength="15" placeholder="- 없이 입력 (ex.01012345678)">
	               
	               <input type="button" value="회원 조회" class="member_search_btn">
	           </li>
	           <li>
					<label for="message">메시지 (선택)</label>
	          		<textarea class="message" name="message" maxlength="100" placeholder="전달하고픈 메시지를 입력해주세요. (최대 100자)"></textarea>
	           </li>
	       </ul>
	       <p class="com_box_design_olist">
	           * 선물하기는 회원 간에만 가능한 서비스입니다.
	       </p>
	  	</div>
	  	</c:if>
	  	
		<!-- 결제 수단 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">결제 수단</strong>
	       <ul class="com_box_design">
	           <li>
					<input type="radio" name="payment" value="1" id="payment1" class="com_custom_radio" id="payment_card" checked>카드 결제 / PAY
	           </li>
	       </ul>
	  	</div>
		
		<!-- 포인트 사용 정보 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">포인트</strong>
	       <ul class="com_box_design">
	           <li>
	               <label for="have_point">보유</label>
	               <input type="text" id="have_point" style="width:228px; text-align:right; padding-right:20px; color:gray;" value="<fmt:formatNumber value="${have_point}"/>" readonly> point
	               
	               <label for="use_point">사용</label>
	               <input type="number" id="use_point" name="use_point" style="width:228px; text-align:right; padding-right:20px;" value="0" maxlength="7"> point
	               
	               <a class="order_point_input_btn order_point_input_btn_N" data-state="N">전액사용</a>
				   <a class="order_point_input_btn order_point_input_btn_Y" data-state="Y" style="display: none;">사용취소</a>
	           </li>
	       </ul>
	  	</div>

		
		<!-- 금액 합계 -->
		<table class="cart_total_price_wrap">
		   <colgroup>
		        <col style="width:33%">
		        <col style="width:34%">
		        <col style="width:33%">
		   </colgroup>
		    
		   <thead>
		        <tr>
		            <th>총 상품 금액</th>
		            <th>포인트 사용 금액</th>
		            <th>총 결제 예정금액</th>
		        </tr>
		   </thead>
		    
		   <tbody>
		        <tr>
		            <td>
		            	<span class="all-total" data-alltotal="${all_total}">
						<fmt:formatNumber value="${all_total}"/>원
						</span>
		            </td>
		            <td class="cart_calculator_marker">
		            	<span class="use-point">
		            	<fmt:formatNumber value="0"/>원
		            	</span>
		            </td>
		            <td style="color:red;">
		            	<span class="final-total">
						<fmt:formatNumber value="${all_total}"/>원
						</span>
					</td>
		        </tr>
		    </tbody>
		</table>
		
		<!-- 버튼 -->
		<div class="btn_wrap">
			<a href="#" id="pay_btn">결제하기</a> 
		</div>

	</form:form>
	<!-- 목록 끝 -->
</div>
<!-- 주문 시작 -->