<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/find_id.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/memberSearch.css">
</head>
<body>
<%@ include file="./Modal.jsp" %>
    <div class="login-box">
        <div class="w3-center w3-large w3-margin-top">
            <h3>아이디 찾기</h3>
        </div>
        <div>
            <div class="user-box">
             	<input class="sc_name" type="text" id="name" name="name" required>
                <label>이름</label>
                <span id="message_id"></span>
            </div>
            <div class="user-box">
            	<input class="sc_phone" type="text" id="phone" name="phone" required>
                <label>전화번호</label>
                <span id="message_id2"></span>
            </div>
            <!-- <div class="w3-center">
                <button type="button" id="find_id" class="">아이디찾기</button>
                <button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">로그인화면</button>
            </div> -->
            
            <a class="find_id">
            <span></span>
		      <span></span>
		      <span></span>
		      <span></span>
            <button type="button" id="find_id" class="no-style-button">아이디찾기</button>
            </a>
        </div>
    </div>
</body>
</html>