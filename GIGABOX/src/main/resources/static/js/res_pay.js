$(function(){
	/*=======================
			   포인트
  	  =======================*/
	const allTotal = parseInt($('.all-total').attr('data-alltotal'));
	const havePoint = parseInt($('#have_point').attr('data-havePoint').replace(/,/g, '')); // 보유 포인트 (정수로 파싱하고 쉼표 제거)
	console.log(allTotal);
	console.log(havePoint);
	
	//총 합계 금액 연산 함수
    function updateFinalTotal() {
        let usePoint = parseInt($(".use-point").val());
		console.log('<<사용 금액>> : ' + usePoint);
        let finalTotal = allTotal - usePoint;
		console.log('<<총 금액>> : ' + finalTotal);

        $('.use-point').text(usePoint.toLocaleString());
        $(".final-total").text(finalTotal.toLocaleString());
		$('#res_total').val(finalTotal);
		$('.res_total_hidden').val(finalTotal);
    }

	//[포인트]사용 포인트 입력 이벤트
    $(".use-point").on("keyup mouseup", function(){
        //입력한 포인트
        let inputValue = $(this).val().trim();

        if (inputValue == '') { // 입력값이 공백일 경우
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
        }else if(state == 'Y'){
            /* 취소 */
            //값 변경
            $(".use-point").val(0);
            updateFinalTotal();
            $('.use-point').text('0');
        }        
        
    });    

});