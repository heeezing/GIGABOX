<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.re-table th {
	text-align: left; /* 가로 가운데 정렬 */
	writing-mode: horizontal-tb;
}
th, td{
	font-size:17px;
	letter-spacing: 1px; 
    line-height: 2.5; 
}
.button-group {
  display: flex;
  justify-content: center; /* 가운데 정렬 */
  align-items: center;
  gap: 40px; /* 버튼 사이 간격 설정 */
  margin-top: 30px;
}

.re-detail-btn {
  background-color: white;
  color: black;
  border: 1px solid #ddd;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
  width:100px;
  height:35px;
}
.re-detail-btn:hover{
	border:solid 1px;
	background-color:#f7f8f9;
}
</style>
<!-- 관람평 상세 내역 시작 -->
<div class="page-main">
	<div class="title">
		<h4>관람평 상세페이지</h4>
		<hr>
	</div>

	<table class="re-table">
		<tr>
			<td><input type="hidden" value="${review.review_num}"></td>
		</tr>
		<tr>
			<th>작성자&nbsp;&nbsp; </th>
			<td colspan="3" class="re-member">${review.mem_num} / ${review.id}</td>
		</tr>
		<tr>
			<th>영화명 </th>
			<td colspan="3">${review.m_title}</td>
		</tr>
		<tr>
			<th>작성일  </th>
			<td colspan="3">${review.review_date}</td>
		</tr>
		<tr>
			<th>평점 </th>
			<td colspan="3">${review.rating_score}</td>
		</tr>
		<tr>
			<th>내용 </th>
			<td colspan="3">${review.review_content}</td>
		</tr>
	</table>
	<div class="button-group">
		<input type="button" value="목록" class="re-detail-btn" onclick="location.href='reportAdmin.do'"> 
		<input type="button" value="삭제" class="re-detail-btn" id="re-delete">
	</div>
</div>
<script type="text/javascript">			
	/* $("#re-delete").click(function(){
		
		let reviewNum = document.querySelector("input[type='hidden']").value;
		$.ajax({
			url:'../movie/reviewDeleteAdmin.do',
			type:'post',
			data:{review_num: reviewNum},
			dataType:'json',
			success:function(param){
				let choice = confirm("정말 삭제하시겠습니까?");
				if(choice){
					if(param.result == 'logout'){
						alert('로그인 후 삭제할 수 있습니다.');
					}else if(param.result == 'success'){
						alert('관람평이 삭제 되었습니다.')
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
	}); */

	let deletebtn = document.getElementById('re-delete');
	//이벤트 연결
	deletebtn.onclick = function() {
		let choice = confirm('삭제하겠습니까?');
		if (choice) {
			alert("관람평 삭제가 완료되었습니다.");
			//히스토리를 지우면서 이동
			location.replace('reviewDeleteAdmin.do?review_num=${review.review_num}');
		}
	};
	
</script>

