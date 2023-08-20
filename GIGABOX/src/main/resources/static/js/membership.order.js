$(function(){
	
	// 인증 토큰 발급 받기

	
	/*=======================
			멤버십 결제
  	  =======================*/
        $('#membership').click(function iamport() {
            // IMP.request_pay(param, callback) 호출
            IMP.init("imp05368653");
            IMP.request_pay({
				pg : "html5_inicis.INIBillTst", // 실제 계약 후에는 실제 상점아이디로 변경
				pay_method : 'card', // 'card'만 지원됩니다.
				merchant_uid: $('#order_num').val(), // 상점에서 관리하는 주문 번호
				name : '최초인증결제',
				amount : 0, // 결제창에 표시될 금액. 실제 승인이 이루어지지는 않습니다. (모바일에서는 가격이 표시되지 않음)
				customer_uid : 'your-customer-unique-id', // 필수 입력.
				buyer_email : 'iamport@siot.do',
				buyer_name : '아임포트',
				buyer_tel : '02-1234-1234',
			}, function(rsp) {
				console.log(rsp);
				if ( rsp.success ) {
				
					alert('빌링키 발급 성공');
				} else {
					alert('빌링키 발급 실패');
				}
			});
       });//end click
	
 });