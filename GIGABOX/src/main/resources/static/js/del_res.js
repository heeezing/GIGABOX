$(function(){
	// 회원
	$('.del-res').click(function(){
		let res_num = $(this).attr('data-num');
		console.log(res_num);
		
		let choice = confirm('해당 영화 예매를 취소하시겠습니까?');
		if(choice){
			$.ajax({
				url:'/reservation/deleteRes.do',
				type:'post',
				data:{res_num:res_num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용 가능합니다.')
					}else if(param.result == 'shortage'){
						alert('적립 받은 포인트를 다 사용하여 회수할 수 없습니다.');
					}else if(param.result = 'success'){
						alert("예매가 취소되었습니다.");
						location.replace('/board/reservationList.do');
					}else{
						alert('영화 예매 취소 처리 오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}else{
			return;
		}
		
	});
	
	// 관리자
	$('.cancel_btn').click(function(){
		let res_num = $(this).attr('data-num');
		console.log(res_num);
		
		let choice = confirm('해당 영화 예매를 취소하시겠습니까?');
		if(choice){
			$.ajax({
				url:'/reservation/deleteRes.do',
				type:'post',
				data:{res_num:res_num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('관리자로 로그인 후 사용 가능합니다.')
					}else if(param.result == 'shortage'){
						alert('해당 회원이 적립 받은 포인트를 다 사용하여 회수할 수 없습니다.');
					}else if(param.result = 'success'){
						alert("예매가 취소되었습니다.");
						location.replace('/reservation/admin_resList.do');
					}else{
						alert('영화 예매 취소 처리 오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}else{
			return;
		}
		
	});
});