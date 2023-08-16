<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상품구매 시작 -->
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
            <form:button class="default-btn">결제하기</form:button>
            <input type="button" value="이전" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/membership/membership_list.do'">
        </div>             
    </form:form>
</div>
<!-- 상품구매 끝 -->
