

	/*============================
	       [관리자] 상태 변경
  	==============================*/

	//개별 상품 상태 변경(사용,취소)
	function statusChange(button) {
	    let num = $(button).data('status'); 
		let detail_num = $(button).data('num');
		let orders_num = $('#orders_num').text();
		
	    if(num == 2){
			let choice = confirm('해당 상품의 주문을 사용완료 처리하시겠습니까?');
			if(choice){
				$.ajax({
					url:'admin_statusChange.do',
					type:'post',
					data:{detail_num:detail_num,orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.')
						}else if(param.result == 'wrongAccess'){
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
					data:{detail_num:detail_num,orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.')
						}else if(param.result == 'wrongAccess'){
							alert('이미 유효하지 않은 주문입니다.')
						}else if(param.result == 'shortage'){
							alert('해당 회원이 적립 받은 포인트를 다 사용하여 회수할 수 없습니다.');
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
	
	
	//전체 상품 상태 변경(사용,취소)
	function statusAllChange(button) {
	    let num = $(button).data('status'); 
		let orders_num = $('#orders_num').text();
		
	    if(num == 2){
			let choice = confirm('해당 주문을 전체 사용 처리하시겠습니까?');
			if(choice){
				$.ajax({
					url:'admin_statusAllChange.do',
					type:'post',
					data:{orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.')
						}else if(param.result == 'wrongAccess'){
							alert('사용할 수 없는 주문입니다.')
						}else if(param.result = 'success'){
							alert("전체 사용 처리 되었습니다.");
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
			let choice = confirm('해당 주문을 전체 취소하시겠습니까?');
			if(choice){
				$.ajax({
					url:'admin_statusAllChange.do',
					type:'post',
					data:{orders_num:orders_num,orders_status:num},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.')
						}else if(param.result == 'wrongAccess'){
							alert('이미 유효하지 않은 주문이 있습니다.')
						}else if(param.result == 'shortage'){
							alert('해당 회원이 적립 받은 포인트를 다 사용하여 회수할 수 없습니다.');
						}else if(param.result = 'success'){
							alert("주문이 전체 취소되었습니다.");
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
	
	
	/*=======================
		 [사용자] 주문 취소
  	=======================*/
	//개별 취소
	function statusChangeUser(button) {
	    let num = $(button).data('status'); //4
		let detail_num = $(button).data('num');
		let orders_num = $('#orders_num').text();
		
		let choice = confirm('해당 상품의 주문을 취소하시겠습니까?');
		if(choice){
			$.ajax({
				url:'../order/admin_statusChange.do',
				type:'post',
				data:{detail_num:detail_num,orders_num:orders_num,orders_status:num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용 가능합니다.')
					}else if(param.result == 'wrongAccess'){
						alert('이미 유효하지 않은 주문입니다.')
					}else if(param.result == 'shortage'){
							alert('적립 받은 포인트를 다 사용하시어 회수할 수 없습니다. 고객센터에 문의해주세요. 1004-1004');
					}else if(param.result = 'success'){
						alert("주문이 취소되었습니다.");
						location.replace('orderDetail.do?orders_num='+orders_num);
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
	}
	
	
	//전체 취소 
	function statusAllChangeUser(button) {
	    let num = $(button).data('status'); //4
		let orders_num = $('#orders_num').text();
		
		let choice = confirm('해당 주문을 전체 취소하시겠습니까?');
		if(choice){
			$.ajax({
				url:'../order/admin_statusAllChange.do',
				type:'post',
				data:{orders_num:orders_num,orders_status:num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용 가능합니다.')
					}else if(param.result == 'wrongAccess'){
						alert('이미 유효하지 않은 주문이 있습니다.')
					}else if(param.result == 'shortage'){
							alert('적립 받은 포인트를 다 사용하시어 회수할 수 없습니다. 고객센터에 문의해주세요. 1004-1004');
					}else if(param.result = 'success'){
						alert("주문이 전체 취소되었습니다.");
						location.replace('orderDetail.do?orders_num='+orders_num);
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
	}

