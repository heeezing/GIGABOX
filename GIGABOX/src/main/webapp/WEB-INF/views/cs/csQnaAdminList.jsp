<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div class="title">
		자주 묻는 질문 목록 관리
	</div>
	<form action="csQnaAdminList.do" method="get" id="search_form">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"
						<c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2"
						<c:if test="${param.keyfield == 2}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" >
			</li>
			<li>
				<input type="submit" value="검색">
				<input type="button" value="목록" onclick="location.href='csQnaAdminList.do'">
			</li>
		</ul>
		<input type="button" value="공지등록" onclick="location.href='csWrite.do'">
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>질문</th>
			<th>등록일</th>
			<th></th>
		</tr>
		<c:forEach var="qna" items="${list}">
		<tr>
			<td class="align-center">${qna.qna_num}</td>
			<td class="align-center">${qna.category_name}</td>
			<td class="align-center">${qna.title}</td>
			<td class="align-center">${qna.reg_date}</td>
			<td>
				<input type="button" value="수정" onclick="location.href='csModify.do?modify_num=${qna.qna_num}&table=1'">
				<input type="button" value="삭제" onclick="location.href='csDelete.do?delete_num=${qna.qna_num}&table=1'">
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>