<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 관리자 - 영화관리 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/movieapi.js"></script>
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
	<div class="apipreview">
	
	</div>
	<form action="movieAdmin.do" id="search_form" method="get">
		<ul class="search">
			<li><select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>영화감독</option>
					<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>영화배우</option>
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
			<input type="button" value="영화 정보 불러오기" id="insertApi">
		</div>
		<div class="align-left">
			<input type="button" value="상영 종료" class="updateStatus_btn">
		</div>
	</form>
	
	<c:if test="${count == 0}">
		<div class="result-display">표시할 영화가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<thead>
			<tr>
				<th><input type="checkbox" name="checkall" id="checkall"> </th>
				<th>포스터</th>
				<th width="40px">번호</th>
				<th>제목</th>
				<th width="100px">개봉일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="movie" items="${movies}">	
				<tr align="center">
					<td><input type="checkbox" class="moviecheck" name="moviecheck" value="${movie.movie_num}"></td>
					<!-- 직접 입력한 포스터가 있으면 그거 먼저 출력 -->
					<c:if test="${!empty movie.m_poster}"><td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}"><img src="../movie/imageView.do?movie_num=${movie.movie_num}&movie_type=1" width="50" height="80"></a></td></c:if>
					<c:if test="${empty movie.m_poster}"><td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}"><img src="${movie.m_poster2}" width="50" height="80"></a></td></c:if>
					<td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}">&nbsp;${movie.movie_num}&nbsp;</a></td>
					
					<td><a href="${pageContext.request.contextPath}/movie/movieDetail.do?movie_num=${movie.movie_num}">${movie.m_title}</a></td>
					<c:if test="${!empty movie.m_opendate}"><td>${movie.m_opendate}</td></c:if>
					<c:if test="${empty movie.m_opendate}"><td>${movie.m_opendate2}</td></c:if>
					<c:if test="${movie.m_status==1}"><td>상영중</td></c:if>
					<c:if test="${movie.m_status==2}"><td>상영예정</td></c:if>
					<c:if test="${movie.m_status==3}"><td>상영종료</td></c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
	<div class="page-button align-center">${page}</div>
</div>
<!-- 체크박스 - 삭제 -->
<script type="text/javascript">
	//전체 선택/해제
	$('#checkall').click(function(){
		if($('#checkall').is(':checked')){//전체선택
			$('.moviecheck').prop('checked',true);
		}else{//전체선택 해제
			$('.moviecheck').prop('checked',false);
		}
	});
	//개별 체크박스 선택/해제
	$('.moviecheck').on('click',function(){
		if($('input[class=moviecheck]:checked').length==$('.moviecheck').length){
			//전체 체크박스 선택
			$('#checkall').prop('checked',true);
		}else{
			//일부 체크박스 선택
			$('#checkall').prop('checked',false);
		}
	});

//선택 삭제
$(".updateStatus_btn").click(function(){
	if($("input[class='moviecheck']:checked").length < 1){
		alert('상영을 중지 시킬 영화를 선택하세요');
		return false;
	}
	
	let selectmovies = new Array();
	
	$("input[class='moviecheck']:checked").each(function(index,item){
		selectmovies.push($(this).val());
	});
	
	$.ajax({
		url:'../movie/moviecheckUpdateStatus.do',
		type:'post',
		data:{selectmovies:selectmovies.toString()},
		dataType:'json',
		success:function(param){
			let choice = confirm("영화 상영을 중지시키시겠습니까?");
			if(choice){
				if(param.result == 'logout'){
					alert('로그인 후 변경할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('영화가 상영종료 되었습니다.')
					history.go(0);
				}else{
					alert('알 수 없는 오류 발생');
				}
			}
		},
		error:function(){
			alert('네트워크 오류 발생');
		}
		
	});
});
</script>

<!-- 관리자 - 영화관리 끝 -->











