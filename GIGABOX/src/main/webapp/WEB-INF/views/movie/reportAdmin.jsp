<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 관리자 - 관람평 신고 시작 -->
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
	<h2>관람평 신고</h2>
	<form action="reportAdmin.do" id="search_form" method="get">
		<ul class="search">
			<li><select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>내용</option>
					<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>ID</option>
			</select></li>
			<li><input type="search" name="keyword" id="keyword"
				value="${param.keyword}"></li>
			<li><input type="submit" value="찾기"> <input
				type="button" value="목록" onclick="location.href='reportAdmin.do'">
			</li>
		</ul>
	</form>
	<div class="align-left">
		<input type="button" value="삭제" class="delete_btn">
	</div>
	
	<c:if test="${count == 0}">
		<div class="result-display">표시할 신고내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<thead>
			<tr>
				<th><input type="checkbox" name="checkall" id="repo_checkall"> </th>
				<th style="width:5%;">신고번호</th>
				<th>신고자ID</th>
				<th>신고날짜</th>
				<th style="width:40%;">관람평 내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="review_report" items="${list}">	
				<tr align="center">
					<td><input type="checkbox" class="repocheck" name="repocheck" value="${review_report.repo_num}"></td>
					<td>&nbsp;${review_report.repo_num}&nbsp;</td>
					<td>${review_report.id}</td> 
					<td>${review_report.repo_date}</td>
					<td><a href="${pageContext.request.contextPath}/movie/reviewDetail.do?review_num=${review.review_num}">${review_report.review_content}</a></td>
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
	$('#repo_checkall').click(function(){
		if($('#repo_checkall').is(':checked')){//전체선택
			$('.repocheck').prop('checked',true);
		}else{//전체선택 해제
			$('.repocheck').prop('checked',false);
		}
	});
	//개별 체크박스 선택/해제
	$('.repocheck').on('click',function(){
		if($('input[class=repocheck]:checked').length==$('.repocheck').length){
			//전체 체크박스 선택
			$('#repo_checkall').prop('checked',true);
		}else{
			//일부 체크박스 선택
			$('#repo_checkall').prop('checked',false);
		}
	});

//선택 삭제
$(".delete_btn").click(function(){
	if($("input[class='repocheck']:checked").length < 1){
		alert('삭제할 항목을 선택하세요');
		return false;
	}
	
	let selectreports = new Array();
	
	$("input[class='repocheck']:checked").each(function(index,item){
		selectreports.push($(this).val());
	});
	
	$.ajax({
		url:'../movie/repocheckDelete.do',
		type:'post',
		data:{selectreports:selectreports.toString()},
		dataType:'json',
		success:function(param){
			let choice = confirm("정말 삭제하시겠습니까?");
			if(choice){
				if(param.result == 'logout'){
					alert('로그인 후 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('신고목록이 삭제 되었습니다.')
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











