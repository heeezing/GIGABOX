$(function(){
	
	/*=======================
		  선물하기 회원 조회
  	  =======================*/	

	let checkMember = 0;
	
	$('.member_search_btn').click(function(){
		if($('#to_id').val().trim() == ''){
			alert('받는 분의 아이디를 입력하세요!');
			$('#to_id').val('').focus();
			return;
		}
		if($('#to_phone').val().trim() == ''){
			alert('받는 분의 전화번호를 입력하세요!');
			$('#to_phone').val('').focus();
			return;
		}
		
		let to_id = $('#to_id').val();
		let to_phone = $('#to_phone').val();
		
		$.ajax({
			url:'searchMember.do',
			type:'post',
			data:{to_id:to_id,
				  to_phone:to_phone},
			dataType:'json',
			success:function(param){
				if(param.result == 'notFound'){
					alert('일치하는 회원이 없습니다.')
					checkMember = 0;
				}else if(param.result = 'success'){
					$('#search_result').text(to_id + '님에게 선물을 발송해드릴게요!');
					checkMember = 1;
				}else{
					checkMember = 0;
					alert('회원 정보 조회 오류');
				}
			},
			error:function(){
				checkMember = 0;
				alert('네트워크 오류 발생');
			}
		});

	});
	
	
	//조회 성공 후에 수정 시 초기화
	$('#to_id').keydown(function(){
		checkMember = 0; //중복값 초기화
		$('#search_result').text(''); //메시지 초기화
	}); 
	$('#to_phone').keydown(function(){
		checkMember = 0; //중복값 초기화
		$('#search_result').text(''); //메시지 초기화
	}); 

	
	
	/*=======================
			   포인트
  	  =======================*/

	const allTotal = parseInt($('.all-total').attr('data-alltotal'));
	const havePoint = parseInt($('#have_point').val().replace(/,/g, '')); // 보유 포인트 (정수로 파싱하고 쉼표 제거)
	
	console.log('<<총 금액>> : ' + allTotal);
	console.log('<<보유포인트>> : ' + havePoint);
	
    //총 합계 금액 연산 함수
    function updateFinalTotal() {
        let usePoint = parseInt($("#use_point").val());
		console.log('<<사용 금액>> : ' + usePoint);
        let finalTotal = allTotal - usePoint;
		console.log('<<총 금액>> : ' + finalTotal);

        $('.use-point').text(usePoint.toLocaleString()+'원');
        $(".final-total").text(finalTotal.toLocaleString()+'원');
    }


    //[포인트]사용 포인트 입력 이벤트
    $("#use_point").on("keyup mouseup", function(){
        //입력한 포인트
        let inputValue = $(this).val().trim();

        if (inputValue === '') { // 입력값이 공백일 경우
            inputValue = '0';
        }

        //숫자로 변환
        inputValue = parseFloat(inputValue);
        //숫자 형식인지 확인
        if(isNaN(inputValue)) {
            $(this).val('');
            inputValue = 0;
        }
        //음수 체크
        if(inputValue < 0) {
            $(this).val('0');
            inputValue = 0;
        }
        //보유포인트보다 많은 수를 입력했을 경우
        if(inputValue > havePoint){
            $(this).val(havePoint);
            inputValue = havePoint;
        }
		//총 금액보다 많은 수를 입력했을 경우
		if(inputValue > allTotal){
            $(this).val(allTotal);
            inputValue = allTotal;
		}
        //소수 입력 시 정수로 반올림 처리
        inputValue = Math.round(inputValue);
        //반올림된 값을 입력 필드에 설정
        $(this).val(inputValue);

		// hidden 태그 업데이트
        $("#use_point_hidden").val(inputValue);

        updateFinalTotal();
    });


    //[포인트]전액 사용 버튼 클릭 이벤트
    $(".order_point_input_btn").on("click", function(){
        let state = $(this).data("state");    
        
        if(state == 'N'){
            /* 모두사용 */
            //값 변경
			if(allTotal < havePoint){
				$("#use_point").val(allTotal);
			}else{
				$("#use_point").val(havePoint);
			}
            updateFinalTotal();
            //글 변경
            $(".order_point_input_btn_Y").css("display", "inline-block");
            $(".order_point_input_btn_N").css("display", "none");
        }else if(state == 'Y'){
            /* 취소 */
            //값 변경
            $("#use_point").val(0);
            updateFinalTotal();
            $('.use-point').text('0원');
            //글 변경
            $(".order_point_input_btn_Y").css("display", "none");
            $(".order_point_input_btn_N").css("display", "inline-block");       
        }        
        
    });    

	 

	/*=======================
			    결제
  	  =======================*/
	
	//[테스트 용] 결제 생략, 바로 주문 완료
	$('#pay_btn').click(function(){
		orderInsert();
	});
	
	//결제하기 버튼 클릭 이벤트
	/*
	$('#pay_btn').click(function iamport(){
		let usePoint = parseInt($("#use_point").val());
		console.log('<<사용 금액>> : ' + usePoint);
        let finalTotal = allTotal - usePoint;
		console.log('<<총 금액>> : ' + finalTotal);
		
		//선물하기일 경우 회원조회를 안 했을 때 조건 체크
		if($('#orders_type').val() == 2){
			if(checkMember == 0){
				alert('선물 받는 분의 회원 조회는 필수입니다.');
				return;
			}else if(checkMember == 1){
				if(finalTotal <= 0){
					let choice = confirm('전액 포인트 사용으로 주문을 완료하시겠습니까?');
					if(choice){
						//주문 등록 처리
				   		orderInsert();
					}else{
						return;
					}
				}else{
					//결제창과 연결
					IMP.init("imp51636682"); //가맹점 식별코드
					IMP.request_pay({
					    pg : 'html5_inicis', //사용할 PG사 
					    pay_method : 'card',
					    merchant_uid : $('#orders_num').val(), //주문번호
					    name : $('#sn_name').val(), //상품명
					    amount : finalTotal, //결제 금액
					    buyer_email : $('#email').val(),
					    buyer_name : $('#name').val(),
					    buyer_tel : $('#phone').val(),
					    buyer_addr : $('#address1').val(),
					    buyer_postcode : $('#zipcode').val()
					}, function(rsp) {
						console.log(rsp);
					    if ( rsp.success ) {
							//주문 등록 처리
					        orderInsert();
					    } else {
							location.replace('orderFail.do');
					    }
					});	
				}
			}else{
				alert('결제 중 오류가 발생했습니다.');
				location.replace('orderFail.do');
			}
		}else if($('#orders_type').val() == 1){
			if(finalTotal <= 0){
				let choice = confirm('전액 포인트 사용으로 주문을 완료하시겠습니까?');
				if(choice){
					//주문 등록 처리
			   		orderInsert();
				}else{
					return;
				}
			}else{
				//결제창과 연결
				IMP.init("imp51636682"); //가맹점 식별코드
				IMP.request_pay({
				    pg : 'html5_inicis', //사용할 PG사 
				    pay_method : 'card',
				    merchant_uid : $('#orders_num').val(), //주문번호
				    name : $('#sn_name').val(), //상품명
				    amount : finalTotal, //결제 금액
				    buyer_email : $('#email').val(),
				    buyer_name : $('#name').val(),
				    buyer_tel : $('#phone').val(),
				    buyer_addr : $('#address1').val(),
				    buyer_postcode : $('#zipcode').val()
				}, function(rsp) {
					console.log(rsp);
				    if ( rsp.success ) {
						//주문 등록 처리
				        orderInsert();
				    } else {
						location.replace('orderFail.do');
				    }
				});	
			}
		}
	}); //end of click
	*/
		
	//order.do로 submit
	function orderInsert(){
		var formObj = $("form[name='order_register']");
			formObj.attr("action", "order.do");
			formObj.attr("method", "post");
			formObj.submit();
	}	
		
		
/*



/*	
	//아임포트 기본 제공 함수
	const IMP = window.IMP; // 생략 가능
	IMP.init("imp51636682"); //가맹점 식별코드
	
	function requestPay() {
	    IMP.request_pay({
	        pg : 'kcp.INIpayTest',
	        pay_method : 'card',
	        merchant_uid: "57008833-33004", //주문번호
	        name : '당근 10kg',
	        amount : 100, //숫자
	        buyer_email : 'Iamport@chai.finance',
	        buyer_name : '포트원 기술지원팀',
	        buyer_tel : '010-1234-5678',
	        buyer_addr : '서울특별시 강남구 삼성동',
	        buyer_postcode : '123-456'
		  }, function (rsp) { // callback
		      if (rsp.success) {
		          // 결제 성공 시 로직
		          alert('성공');
		      } else {
		          // 결제 실패 시 로직
		          alert('실패');
		      }
		  });
		}
*/



});
