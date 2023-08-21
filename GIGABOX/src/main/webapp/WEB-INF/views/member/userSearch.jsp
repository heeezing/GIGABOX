<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/find_id.js"></script>
</head>
<body>
<%@ include file="./Modal.jsp" %>
<div class="w3-content w3-container w3-margin-top">
    <div class="w3-container w3-card-4">
        <div class="w3-center w3-large w3-margin-top">
            <h3>아이디 찾기</h3>
        </div>
        <div>
            <p>
                <label>이름</label>
                <input class="w3-input" type="text" id="name" name="name" placeholder="이름을 입력해주세요." required>
            </p>
            <p>
                <label>전화번호</label>
                <input class="w3-input" type="text" id="phone" name="phone" placeholder="핸드폰 번호를 입력해주세요." required>
            </p>
            <p class="w3-center">
                <button type="button" id="find_id" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">아이디찾기</button>
                <button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">로그인화면</button>
            </p>
        </div>
    </div>
</div>
</body>
</html>