<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 멤버십 목록 시작-->
<div class="page-main">
	<h2>멤버십 목록</h2>
	<form action="membership_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>등급</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>혜택</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>가격</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" 
				   onclick="location.href='membership_list.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>등급</th>
			<th>혜택</th>
			<th>가격</th>
			<th>수정/삭제</th>
		</tr>
		<c:forEach var="membership" items="${list}">
		<tr align="center">
			<td>${membership.membership_grade}</td>
			<td>${membership.membership_detail}</td>
			<td>${membership.price}</td>
			<td>
			<input type="button" value="수정"
			onclick="location.href='membership_update.do?membership_id=${membership.membership_id}'">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('membership_delete.do?membership_id=${membership.membership_id}');
					}
				}
			</script>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	<div class="align-right">
		<input type="button" value="등록하기" 
			onclick="location.href='registerMembership.do'">
	</div>
</div>
<!-- 멤버십 목록 종료 -->

















