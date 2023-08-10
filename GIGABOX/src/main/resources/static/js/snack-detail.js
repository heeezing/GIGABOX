$(function(){
	/*-------------------
	 	  주문 수량 변경
	--------------------*/
		 
	//총 주문 금액 연산 함수
	function selectTotal(num){
		if($('#sn_dc_price').val() == 0){
			let total = $('#sn_price').val() * num;
			$('.txt_price_str').text(total.toLocaleString());
		}else{
			let total = $('#sn_dc_price').val() * num;
			$('.txt_price_str').text(total.toLocaleString());
		}
	}
	
	//수량 변경 버튼 클릭 이벤트 (+,-)
	$('.btn_mins').click(function(e){
		e.preventDefault();
		let orders_quantity = $('#orders_quantity').val();
		let num = parseInt(orders_quantity);
		num--;
		if(num <= 0){
			num = 1;
		}
		$('#orders_quantity').val(num);
		//총 주문 금액 업데이트
		selectTotal(num);
	});
		
	$('.btn_plus').click(function(e){
		e.preventDefault();
		let orders_quantity = $('#orders_quantity').val();
		let num = parseInt(orders_quantity);
		num++;
		if(num>10){
			alert('최대 10개의 상품 구매가 가능합니다.');
			num = 10;
		}
		$('#orders_quantity').val(num);
		//총 주문 금액 업데이트
		selectTotal(num);
	});



	/*-------------------
 	 	  장바구니 담기
	--------------------*/
	$('#item_cart').submit(function(event){
		let form_data = $(this).serialize();
		//서버와 통신
		$.ajax({
			url:'../cart/write.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					let choice = confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?');
					 if(choice){
						 //히스토리를 지우면서 이동
						 location.replace('../member/login.do');
					 }
				}else if(param.result == 'success'){
					 let choice = confirm('장바구니에 등록되었습니다. 확인하시겠습니까?');
					 if(choice){
						 location.href='../cart/list.do';
					 }
				}else if(param.result == 'overQuantity'){
					let choice = confirm('최대 10개의 상품만 담을 수 있습니다. 장바구니로 이동하시겠습니까?');
					 if(choice){
						 //히스토리를 지우면서 이동
						 location.href='../cart/list.do';
					 }
				}else{
					alert('장바구니 담기 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트(submit) 제거
		event.preventDefault();
		
	});



	/*--------------------------
 	 	바로 구매 - 주문폼으로 이동
	----------------------------*/
	$('#btn_order').click(function(e){
		e.preventDefault();
		
		//서버와 통신
		$.ajax({
			url:'../order/orderForm.do',
			type:'post',
			data:{sn_num:$('#sn_num').val,
				  orders_quantity:$('#orders_quantity').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					let choice = confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?');
					 if(choice){
						 //히스토리를 지우면서 이동
						 location.replace('../member/login.do');
					 }
				}else if(param.result == 'success'){
					location.href='../cart/list.do';
				}else{
					alert('장바구니 담기 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});




	
});