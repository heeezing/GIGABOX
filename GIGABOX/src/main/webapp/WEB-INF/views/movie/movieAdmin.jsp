<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 관리자 - 영화관리 시작 -->
<script type="text/javascript">
	$(function() {
		//검색 유효성 체크
		$('#search_form').submit(function() {
			if ($('#keyword').val().trim() == '') {
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<h2>영화관리</h2>
	<form action="movieAdmin.do" id="search_form" method="get">
		<ul class="search">
			<li><select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화감독</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화배우</option>
			</select></li>
			<li><input type="search" name="keyword" id="keyword"
				value="${param.keyword}"></li>
			<li><input type="submit" value="찾기"> <input
				type="button" value="목록" onclick="location.href='movieAdmin.do'">
			</li>
		</ul>
		<div class="align-right">
			<input type="button" value="등록"
				onclick="location.href='movieRegister.do'">
		</div>
		<div class="align-left">
			<input type="button" value="삭제" class="movie_deletebtn">
		</div>
	</form>
	
	<c:if test="${count == 0}">
		<div class="result-display">표시할 영화가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<thead>
			<tr>
				<th><input type="checkbox" name="selectall" id="selectall"> </th>
				<th>영화번호</th>
				<th>제목</th>
				<th>개봉일</th>
				<th>감독</th>
				<th>출연진</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="movie" items="${movies}">	
				<tr align="center">
					<td><input type="checkbox" class="moviecheck" name="moviecheck" value="${movie.movie_num}"></td>
					<td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}">${movie.movie_num}</a></td>
					<td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}">${movie.m_title}</a></td>
					<td>${movie.m_opendate}</td>
					<td>${movie.m_director}</td>
					<td>${movie.m_actor}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 체크박스 선택 -> 삭제 이벤트 -->
	<script type="text/javascript">
		//선택삭제		
		$('.movie_deletebtn').click(function(){
			if($('input:checkbox[name=moviecheck]:checked').length<1){
				alert('삭제할 항목을 선택하세요.');
				return false;
			}
			let checkdel = new Array();
			$('input:checkbox[name=moviecheck]:checked').each(function(index,item){
				checkdel.push($(this).val());
			});
			$.ajax({
				url:'movieDelete.do',
				type:'post',
				data:{'checkdel':checkdel.toString()},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 삭제할 수 있습니다.');
					}else if(param.result == 'success'){
						alert('영화가 삭제되었습니다.')
						history.go(0);
					}else if(param.result == 'wrongAccess'){
						alert('잘못된 접근입니다.');
					}else{
						alert('알 수 없는 오류가 발생했습니다.')
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		});
	</script>
	</c:if>
	<div class="page-button align-center">${page}</div>
</div>

<!-- 관리자 - 영화관리 끝 -->