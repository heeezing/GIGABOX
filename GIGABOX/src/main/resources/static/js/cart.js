$(function(){
	/*---------------------
	   장바구니 체크박스 제어
	----------------------*/
	
	/*-----전체 선택&해제-----*/
	
	//장바구니에 담겨있는 상품의 총 구매 금액
	let cart_sum = $('.all-total').attr('data-alltotal');
	let cart_origin_sum = $('.origin-total').attr('data-origintotal');
	let cart_dc_sum = $('.dc-total').attr('data-dctotal');
	
	$('#chk_all').on('click',function(){
		if($('#chk_all').is(':checked')){ //전체 선택 체크
			$('.choice-btn').prop('checked',true);
			
			//모두 선택하면 원래의 총 구매 금액으로 환원
			$('.all-total').attr('data-alltotal',cart_sum);
			$('.origin-total').attr('data-origintotal',cart_origin_sum);
			$('.dc-total').attr('data-dctotal',cart_dc_sum);
			
		}else{ //전체 선택 해제
			$('.choice-btn').prop('checked',false);
			
			$('.origin-total').text('0원');
			$('.all-total').text('0원');
			$('.dc-total').text('0원');
			$('.origin-total').attr('data-origintotal',0);
			$('.dc-total').attr('data-dctotal',0);
			$('.all-total').attr('data-alltotal',0);
		}
		
		//총 구매 금액 표시
		$('.all-total').text(Number($('.all-total').attr('data-alltotal')).toLocaleString()+'원');
		$('.origin-total').text(Number($('.origin-total').attr('data-origintotal')).toLocaleString()+'원');
		$('.dc-total').text(Number($('.origin-total').attr('data-origintotal') - ($('.all-total').attr('data-alltotal'))).toLocaleString()+'원');
		
	});

	
	/*-----개별 선택&해제-----*/
	
	//체크박스를 전부 선택하면 #chk_all 선택, 하나라도 해제하면 #chk_all 해제 
	$('.choice-btn').on('click',function(){
		if($('input[class=choice-btn]:checked').length == $('.choice-btn').length){
			//전체 체크박스 선택
			$('#chk_all').prop('checked',true);
		}else{
			//부분 체크박스 선택
			$('#chk_all').prop('checked',false);
		}
		
		//총 구매 금액 처리
		//하나라도 선택된 것이 있으면 true, 아예 없으면 false 반환
		if($('.choice-btn').is(':checked')){
			//총 구매 금액을 선택,미선택에 따라 다시 산출
			if($(this).is(':checked')){ //선택 O
				//연산하여 data-alltotal에 데이터 세팅
				$('.all-total').attr('data-alltotal', 
									  Number($('.all-total').attr('data-alltotal'))
									+ Number($(this).parents('tr').find('.sub-total').attr('data-total')));
				//연산하여 data-origintotal에 데이터 세팅
				$('.origin-total').attr('data-origintotal', 
									  Number($('.origin-total').attr('data-origintotal'))
									+ Number($(this).parents('tr').find('.sub-total input[type="hidden"]').attr('data-realtotal')));
			}else{ //선택 X
				//연산하여 data-alltotal에 데이터 세팅
				$('.all-total').attr('data-alltotal', 
									  $('.all-total').attr('data-alltotal') 
									- $(this).parents('tr').find('.sub-total').attr('data-total'));
				//연산하여 data-origintotal에 데이터 세팅
				$('.origin-total').attr('data-origintotal', 
									  	$('.origin-total').attr('data-origintotal')
									  - $(this).parents('tr').find('.sub-total input[type="hidden"]').attr('data-realtotal'));
			}
			
		}else{ //하나도 선택한 게 없는 경우
			//연산하여 data-alltotal에 데이터 세팅
			$('.all-total').attr('data-alltotal', 
								  $('.all-total').attr('data-alltotal') 
								- $(this).parents('tr').find('.sub-total').attr('data-total'));
			//연산하여 data-origintotal에 데이터 세팅
			$('.origin-total').attr('data-origintotal', 
								  	$('.origin-total').attr('data-origintotal')
								  - $(this).parents('tr').find('.sub-total input[type="hidden"]').attr('data-realtotal'));
		}
		
		//총 구매 금액 표시
		$('.all-total').text(Number($('.all-total').attr('data-alltotal')).toLocaleString()+'원');
		$('.origin-total').text(Number($('.origin-total').attr('data-origintotal')).toLocaleString()+'원');
		$('.dc-total').text(Number($('.origin-total').attr('data-origintotal') - ($('.all-total').attr('data-alltotal'))).toLocaleString()+'원');
	});


	
	/*---------------------
	   장바구니 상품 수량 변경
	----------------------*/
	
	//수량 [-] 버튼 클릭 이벤트
	$('.minus').click(function(e){
	    e.preventDefault();
	    let inputElement = $(this).siblings('.inp');
	    let orders_quantity = inputElement.val();
	    let num = parseInt(orders_quantity);
	    num--;
	    if (num <= 0) {
	        num = 1;
	    }
	    inputElement.val(num);
	});
		
	//수량 [+] 버튼 클릭 이벤트
	$('.plus').click(function(e){
		e.preventDefault();
		let inputElement = $(this).siblings('.inp');
   		let orders_quantity = inputElement.val();
		let num = parseInt(orders_quantity);
		num++;
		if(num>10){
			alert('최대 10개의 상품 구매가 가능합니다.');
			num = 10;
		}
		inputElement.val(num);
	});

	
	//수량 [변경] 버튼 클릭 이벤트
	$('.cart-modify').on('click',function(){
		let input_quantity = $(this).parent().find('.count-wrap input[name="orders_quantity"]');
		
		//서버와 통신
		$.ajax({
			url:'modifyCart.do',
			type:'post',
			data:{cart_num:$(this).attr('data-cartnum'),
				  sn_num:$(this).attr('data-snnum'),
				  orders_quantity:input_quantity.val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'noSale'){
					alert('판매가 중지된 상품입니다.');
					location.replace('list.do'); //화면 갱신
				}else if(param.result == 'success'){
					alert('수량이 변경되었습니다.');
					location.replace('list.do'); //화면 갱신
				}else{
					alert('장바구니 수량 변경 오류 발생');
				}	
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}); //end of click(수량변경)
	
	
	
	/*-------------------
	 	장바구니 상품 삭제
	--------------------*/
	
	//상품 개별 삭제
	$('.cart-del').on('click',function(){
		// 확인을 누를 때만 삭제 동작 실행
	    if(confirm("선택하신 상품을 삭제하시겠습니까?")) {
			//서버와 통신
			$.ajax({
				url:'deleteCart.do',
				type:'post',
				data:{cart_num:$(this).attr('data-cartnum')},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용 가능합니다.');
						location.href='../member/login.do';
					}else if(param.result == 'success'){
						alert('삭제가 완료되었습니다.');
						location.replace('list.do'); //화면 갱신
					}else{
						alert('장바구니 상품 삭제 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
		return;
	}); //end of click(삭제)
	
	
	//선택 삭제 버튼 클릭 이벤트
	 $("#selectDelete_btn").click(function(){
	 		if($("input[class='choice-btn']:checked").length < 1){
				alert('삭제할 항목을 선택하세요');
				return false;
			}
			
		   let checkArr = new Array();
		   
		   $("input[class='choice-btn']:checked").each(function(index,item){
		    	checkArr.push($(this).val());
		   });
		   
		   $.ajax({
			    url:'deleteChBox.do',
			    type:'post',
			    data:{checkArr:checkArr.toString()},
			    dataType:'json',
			    success : function(param){
			    	let choice = confirm("선택하신 상품을 삭제하시겠습니까?");
			    	if(choice){
						if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.');
						}else if(param.result == 'success'){
							alert('삭제가 완료되었습니다.');
							location.replace('list.do'); //화면 갱신
						}else{
							alert('장바구니 상품 삭제 오류 발생');
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
	
	
	
	/*-------------------
			주문하기
	--------------------*/
	
	//선물하기 버튼 클릭 이벤트
	function cartGift(event){
		event.stopPropagation(); 
		document.cart_order.action="../order/giftForm.do";
		document.cart_order.submit();
	}
	//선물하기 버튼 클릭 이벤트
	$('#cart_gift').click(function(){
		cartGift();
	});
	
	//구매하기 버튼 클릭 이벤트
	function cartOrder(event){
		event.stopPropagation(); 
		document.cart_order.action="../order/orderForm.do";
		document.cart_order.submit();
	}
	
	//구매하기 버튼 클릭 이벤트
	$('#cart_order').click(function(){
		cartOrder();
	});





});