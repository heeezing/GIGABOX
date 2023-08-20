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


<div class="page-main">
	<div class="title" align="center">
		<b>GIGA 멤버십</b>
	</div>
	
	<hr size="2" noshade="noshade">
	
    <h2>결제 정보</h2>
    <form:form modelAttribute="membershipOrderVO" action="msorderForm.do" id="order_register"> 
       <!-- 선택한 멤버십 정보만 출력 -->
        <table class="basic-table">
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
            <input type="button" value="이전" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/membership/membership_list.do'">
        </div>             
    </form:form>
</div>
<!-- 상품구매 끝 -->

<script>
BootPay.request({
	price: 0, // 0으로 해야 한다.
	application_id: "64e2311100be04001aa38e4d",
	name: '정기적인 결제', //결제창에서 보여질 이름
	pg: 'nicepay',
	method: 'card_rebill', // 빌링키를 받기 위한 결제 수단
	show_agree_window: 0, // 부트페이 정보 동의 창 보이기 여부
	user_info: {
		username: '사용자 이름',
		email: '사용자 이메일',
		addr: '사용자 주소',
		phone: '010-1234-4567'
	},
	order_id: '고유order_id_1234', //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
	params: {callback1: '그대로 콜백받을 변수 1', callback2: '그대로 콜백받을 변수 2', customvar1234: '변수명도 마음대로'},
	extra: {
		start_at: '2019-05-10', // 정기 결제 시작일 - 시작일을 지정하지 않으면 그 날 당일로부터 결제가 가능한 Billing key 지급
		end_at: '2022-05-10' // 정기결제 만료일 -  기간 없음 - 무제한
	}
}).error(function (data) {
	//결제 진행시 에러가 발생하면 수행됩니다.
	console.log(data);
}).cancel(function (data) {
	//결제가 취소되면 수행됩니다.
	console.log(data);
}).done(function (data) {
	// 빌링키를 정상적으로 가져오면 해당 데이터를 불러옵니다.
	console.log(data);
	import { RestClient } from "@bootpay/server-rest-client"
	// or
	const RestClient = require('@bootpay/server-rest-client').RestClient;

	RestClient.setConfig(
	    '[[ 64e2311100be04001aa38e50 ]]',
	    '[[ kSwOr6gQgDRzZSNd+leIoWbGJbzDg/YSwGsrc/zeHkA= ]]'
	);


	RestClient.getAccessToken().then(function (token) {
	    if (token.status === 200) {
	        RestClient.requestSubscribeBillingPayment({
	            billingKey: '[[ billing_key ]]', // 빌링키
	            itemName: '정기결제 아이템', // 정기결제 아이템명
	            price: 3000, // 결제 금액
	            taxFree: 0, // 비과세 금액 ( 0원이면 생략 가능 )
	            orderId: '[[ order_id ]]', // 유니크한 주문번호
	            quota: 0, // 할부 개월수 0 - 일시불, 3 - 3개월 ( 5만원 이상부터 가능 )
	            userInfo: {
	                username: 'test',
	                email: 'test@bootpay.co.kr',
	                phone: '01000000000',
	                address: '[[ 지역 ]]'
	            },
	            feedbackUrl: '[[ 결제 완료후 Feedback 받을 https가 포함된 URL ]]',
	            feedbackContentType: '[[ json or urlencoded ]]',
	            items: [
	                {
	                    itemName: '정기 결제 아이템명',
	                    qty: 1,
	                    unique: '아이템 유니크값',
	                    price: 3000,
	                    cat1: '카테고리1',
	                    cat2: '카테고리2',
	                    cat3: '카테고리3'
	                }
	            ]
	        }).then(function (response) {
	            if (response.status === 200) {
	                // TODO: 결제 완료된 로직을 처리하시면 됩니다.
	            }
	        });
	    }
	});
});
</script>
