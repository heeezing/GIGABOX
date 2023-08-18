	/*=======================
		   사용 상태 변경
  	=======================*/
	function statusChange(button) {
	    let num = $(button).data('status');
		let orders_num = $('#orders_num').text();
		
	    if(num == 2){
			let choice = confirm('해당 상품의 주문을 사용완료 처리하시겠습니까?');
			if(choice){
				$.ajax({
					url:'admin_statusChange.do',
					type:'post',
					data:{orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'wrongAccess'){
							alert('사용할 수 없는 주문입니다.')
						}else if(param.result = 'success'){
							alert("사용완료 처리 되었습니다.");
							location.replace('admin_detail.do?orders_num='+orders_num);
						}else{
							alert('사용 완료 처리 오류');
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});
			}else{
				return;
			}
			
		}else if(num == 4){
			let choice = confirm('해당 상품의 주문을 취소하시겠습니까?');
			if(choice){
				$.ajax({
					url:'admin_statusChange.do',
					type:'post',
					data:{orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'wrongAccess'){
							alert('이미 유효하지 않은 주문입니다.')
						}else if(param.result = 'success'){
							alert("주문이 취소되었습니다.");
							location.replace('admin_detail.do?orders_num='+orders_num);
						}else{
							alert('주문 취소 처리 오류');
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});
			}else{
				return;
			}
			
		}else{
			alert('네트워크 오류 발생');
		}
	
	}
