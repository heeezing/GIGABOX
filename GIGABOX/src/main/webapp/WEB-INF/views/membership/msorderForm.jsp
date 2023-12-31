<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품구매 시작 -->
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- bootpay -->
<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.1.min.js" type="application/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/membership.order.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/membership.css">
<div class="page-util">
	<div class="location">
		<span style="cursor: pointer;" onclick="window.location.href='${pageContext.request.contextPath}/main/main.do'">홈</span> 
		<a href="../membership/membership_list.do">멤버십</a> 
		<a href="#">결제</a>
	</div>
</div>

<div class="page-main">
	<div class="title" align="center">
		<b>GIGA 멤버십</b>
	</div>
	
	<hr size="2" noshade="noshade">
	
    <strong class="com_box_design_title">결제 정보</strong>
    <form:form modelAttribute="membershipOrderVO" action="msorderForm.do" id="order_register"> 
       <!-- 선택한 멤버십 정보만 출력 -->
        <table class="membership-table">
        	<thead>
            <tr>
                <th>멤버십 등급</th>
                <th>혜택</th>
                <th>가격</th>
            </tr>
            </thead>
            	
            
            <tbody>
            <tr>
                <td class="align-center">${selectedMembership.membership_grade}</td>
                <td class="align-center">${selectedMembership.membership_benefits}</td>
                <td class="align-center"><fmt:formatNumber value="${selectedMembership.price}"/>원</td>
            </tr>
            </tbody>
        </table>
        
        <!-- 결제 수단 -->
		<div class="com_box_design_wrap">
		<strong class="com_box_design_title" style="margin:0 0 10px 0;">결제 수단</strong>
	       <ul class="com_box_design">
	           <li>
					<input type="radio" name="payment" value="1" id="payment1" class="com_custom_radio" id="payment_card" checked>카드 결제
	           </li>
	       </ul>
	  	</div>
        
        <div class="align-center">
            <input type="button" value="결제" id="membership_pay">
            <input type="button" value="이전" class="back-btn" onclick="location.href='${pageContext.request.contextPath}/membership/membership_list.do'">
        </div>             
    </form:form>
</div>
<!-- 상품구매 끝 -->

<%
    String billingKeyFromServer = "billing_key"; // 실제 값을 가져오는 코드로 대체해야 합니다.
%>

<script>
$(document).ready(function() {
	
	
	var order_num = ${order_num};
	var billing_key = '<%= billingKeyFromServer %>';
	
    $("#membership_pay").click(function() {
        BootPay.request({
            price: 0, // 0으로 해야 한다.
            application_id: "64e2311100be04001aa38e4d",
            name: '정기적인 결제', // 결제창에서 보여질 이름
            pg: 'nicepay',
            method: 'card_rebill', // 빌링키를 받기 위한 결제 수단
            show_agree_window: 0,
            user_info: {
                username: '사용자 이름',
                email: '사용자 이메일',
                addr: '사용자 주소',
                phone: '010-1234-4567'
            },
            order_id: order_num,
            params: {callback1: '그대로 콜백받을 변수 1', callback2: '그대로 콜백받을 변수 2', customvar1234: '변수명도 마음대로'},
            extra: {
                start_at: '2023-08-25', // 정기 결제 시작일 - 시작일을 지정하지 않으면 그 날 당일로부터 결제가 가능한 Billing key 지급
                end_at: '2023-08-26' // 정기결제 만료일 -  기간 없음 - 무제한
            }
            
        }).error(function (data) {
            // 결제 진행시 에러가 발생하면 수행됩니다.
            console.log(data);
            alert("결제시 문제가 발생되었습니다.");
        }).cancel(function (data) {
            // 결제가 취소되면 수행됩니다.
            console.log(data);
            alert("결제가 취소되었습니다.");
        }).done(function (data) {
            // 빌링키를 정상적으로 가져오면 해당 데이터를 불러옵니다.
            console.log(data);

            // 결제가 완료되었으므로 데이터베이스에 저장하고자 하는 정보를 변수에 담습니다.
            var orderNum = ${order_num}; // 결제한 주문번호
            var memNum = ${user.mem_num}; // 사용자 회원 번호
            var membershipId = ${selectedMembership.membership_id}; // 선택한 멤버십 ID
            var price = ${selectedMembership.price}; // 선택한 멤버십 가격
            var membership_grade = '${selectedMembership.membership_grade}'; //선택한 멤버십 등급

            // AJAX 요청을 통해 데이터베이스에 저장합니다.
            $.ajax({
                url: "${pageContext.request.contextPath}/membership/msorder.do",
                type: "POST",
                data: {
                    order_num: orderNum,
                    mem_num: memNum,
                    membership_id: membershipId,
                    price: price,
                    pay_type:'카드결제',
                    pay_date: '2023-08-25',
                    next_pay_date: '2023-09-25',
                    billing_key: billing_key,
                    result_status: '테스트 결제',
                    result_message: '결제 성공',
                    membership_grade: membership_grade
                },
                success: function(result) {
                    console.log("Order saved successfully:", result);
                    // 결제가 완료되었으므로 사용자에게 알림을 표시합니다.
                    alert("결제가 완료되었습니다.");
                    location.href = "msorderComplete.do"
                },
                error: function(error) {
                    console.log("Error saving order:", error);
                    // 결제 실패 시 사용자에게 알림을 표시합니다.
                    alert("결제가 실패하였습니다.");
                }
            });
        });
    });
});
</script>
