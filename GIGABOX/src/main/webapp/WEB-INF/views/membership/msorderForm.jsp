<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품구매 시작 -->
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js" type="text/javascript"></script>
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
            <tr>
                <th>멤버십 등급</th>
                <th>혜택</th>
                <th>가격</th>
            </tr>
            <tr>
                <td class="align-center">${selectedMembership.membership_grade}</td>
                <td class="align-center">${selectedMembership.membership_benefits}</td>
                <td class="align-center"><fmt:formatNumber value="${selectedMembership.price}"/>원</td>
            </tr>
        </table>
        
        <div class="align-center">
            <input type="button" value="결제" >
            <input type="button" value="이전" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/membership/membership_list.do'">
        </div>             
    </form:form>
</div>
<!-- 상품구매 끝 -->

<script>
  BootPay.request({
      price: '${selectedMembership.price}', //실제 결제되는 가격
 
      // 관리자로그인 -> 결제설치 -> 인증키 및 보안 -> WEB Application ID
      application_id: "64e2311100be04001aa38e4d",
 
      name: '${selectedMembership.membership_grade}', //결제창에서 보여질 이름
      pg: 'nicepay',
      method: 'card', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
      show_agree_window: 0, // 부트페이 정보 동의 창 보이기 여부
      items: [
          {
              item_name: '${selectedMembership.membership_grade}', //상품명
              qty: 1, //수량
              unique: '123', //해당 상품을 구분짓는 primary key
              price: ${selectedMembership.price}, //상품 단가
          }
      ],
      order_id: '고유order_id_1234', //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
  }).error(function (data) {
      //결제 진행시 에러가 발생하면 수행됩니다.
      console.log(data);
  }).cancel(function (data) {
      //결제가 취소되면 수행됩니다.
      console.log(data);
  }).close(function (data) {
      // 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
      console.log(data);
  }).done(function (data) {
      //결제가 정상적으로 완료되면 수행됩니다
      //비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
      console.log(data);
  });
</script>

