<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 게시판 목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div class="title"><a href="admin_list.do">상품 목록</a></div>
	<!-- 검색창 -->
	<form action="admin_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" 
					  <c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
					<option value="2" 
					  <c:if test="${param.keyfield == 2}">selected</c:if>>구성</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>
		<input type="button" value="삭제" id="selectDelete_btn" style="float:left;">
		<!-- 정렬 -->
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" 
				  <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" 
				  <c:if test="${param.order == 2}">selected</c:if>>가나다순</option>
				<option value="3" 
				  <c:if test="${param.order == 3}">selected</c:if>>카테고리순</option>
			</select>
			<script type="text/javascript">
				$(function(){
					$('#order').change(function(){
						location.href='admin_list.do?keyfield='+$('#keyfield').val() 
											+ '&keyword='+$('#keyword').val() 
											+ '&order='+$('#order').val();
					});
				});
			</script>
			
			<input type="button" value="등록" onclick="location.href='admin_insert.do'">
			<!--<c:if test="${!empty user}">
				나중에 등록 버튼에 관리자 조건 주기
			</c:if>-->
		</div>
	</form>

	<!-- 목록 -->
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th><input type="checkbox" name="allCheck" id="allCheck"></th>
			<th>상품명</th>
			<th>구성</th>
			<th>가격</th>
			<th>카테고리</th>
			<th>판매여부</th>
		</tr>
		<c:forEach var="snack" items="${list}">
		<tr>
			<td><input type="checkbox" class="chBox" name="chBox" value="${snack.sn_num}"></td>
			<td class="align-center">
				<a href="admin_update.do?sn_num=${snack.sn_num}">${snack.sn_name}</a>
			</td>
			<td class="align-center">${snack.sn_detail}</td>
			<td class="align-center"><fmt:formatNumber value="${snack.sn_price}"/></td>
			<td class="align-center">
				<c:if test="${snack.sn_category==1}">콤보</c:if>
				<c:if test="${snack.sn_category==2}">팝콘</c:if>
				<c:if test="${snack.sn_category==3}">음료</c:if>
				<c:if test="${snack.sn_category==4}">스낵</c:if>
			</td>
			<td class="align-center">
				<c:if test="${snack.sn_status==1}">판매중</c:if>
				<c:if test="${snack.sn_status==2}">판매중지</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<script type="text/javascript">
		//모두 선택 체크박스 클릭 이벤트
		$("#allCheck").click(function(){
			 var chk = $("#allCheck").prop("checked");
			 if(chk) {
			  $(".chBox").prop("checked", true);
			 } else {
			  $(".chBox").prop("checked", false);
			 }
		});
		
		//모두 선택일 때 개별 체크박스 하나 해제 시 모두 선택 해제
		 $(".chBox").click(function(){ 
			  $("#allCheck").prop("checked", false);
		});
		
		
		//선택 삭제 버튼 클릭 이벤트
		 $("#selectDelete_btn").click(function(){
		 		if($("input[class='chBox']:checked").length < 1){
					alert('하나 이상의 항목을 선택하세요');
					return false;
				}
				
			   let checkArr = new Array();
			   
			   $("input[class='chBox']:checked").each(function(index,item){
			    	checkArr.push($(this).val());
			   });
			   
			   $.ajax({
				    url:'../snack/admin_deleteChBox.do',
				    type:'post',
				    data:{checkArr:checkArr.toString()},
				    dataType:'json',
				    success : function(param){
				    	let choice = confirm("삭제하시겠습니까?");
				    	if(choice){
							if(param.result == 'logout'){
								alert('로그인 후 삭제할 수 있습니다.');
							}else if(param.result == 'success'){
								alert('상품 삭제가 완료되었습니다.');
								location.href='../snack/admin_list.do';
							}else{
								alert('상품 삭제 중 오류가 발생했습니다.');
							}
						}else{
							return false;
						}
				    },
				    error:function(){
				    	alert('네트워크 오류 발생');
				    }
			   });
		 });
		</script>
	
	<!-- 페이지 -->
	<div class="align-center">${page}</div>
	</c:if>
	
</div>
<!-- 게시판 목록 끝 -->
