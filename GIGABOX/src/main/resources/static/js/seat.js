$(function(){
	let number = 0; // 인원수
	let seats = []; // 선택한 좌석
	let clicked = 0; // 선택된 좌석 개수
	
	// 초기화
	$('#reset_btn').click(function(){
		if(clicked>0){ // 클릭한 좌석이 있는 경우
			let choice = confirm('초기화하겠습니까?');
			if(choice){
				// 선택한 좌석 초기화
				$('.seat.selected').removeClass('selected');
				// 선택한 좌석 정보 초기화
				for (let i=1;i<=clicked;i++) {
				    $('#my_selected_seat' + i).text('-');
				    $('#my_selected_seat' + i).css('background-color', 'transparent');
				}
				// 클릭 횟수 초기화
				clicked = 0;
				// 인원수 초기화
				number = 0;
				
				// 선택한 좌석 초기화
				seats = [];
				$('#res_seats').val(seats.toString());
			}
		}
		$('.number').val(number);
		$('.person').text(number);
		
		$('#btn_booking_pay').prop('disabled', true); // 결제버튼 비활성화
		
	});
	
	// 인원수 - 버튼 클릭
	$('.down').click(function(){
		if(number>0 && number>clicked){ // 인원수가 0명 이상이고, 인원수보다 선택한 좌석수가 적은 경우 빼기
			--number;
		}else if(number>0 && number==clicked){ // 인원수만큼 좌석 선택되어있는 경우 좌석 초기화
			let choice = confirm('선택한 좌석이 존재합니다. 좌석 정보를 초기화하겠습니까?');
			if(choice){
				// 선택한 좌석 초기화
				$('.seat.selected').removeClass('selected');
				// 선택한 좌석 정보 초기화
				for (let i=1;i<=clicked;i++) {
				    $('#my_selected_seat' + i).text('-');
				    $('#my_selected_seat' + i).css('background-color', 'transparent');
				}
				// 클릭 횟수 초기화
				clicked = 0;
				// 인원수 -1
				--number;
				
				// 선택한 좌석 초기화
				seats = [];
				$('#res_seats').val(seats.toString());
				
				$('#btn_booking_pay').prop('disabled', true); // 결제버튼 비활성화
			}
		}
		$('.number').val(number);
		$('.person').text(number);
	});
	
	// 인원수 + 버튼 클릭
	$('.up').click(function(){
		if(number<8){ // 인원수는 8명까지만 가능
			++number;
			$('.number').val(number);
			$('.person').text(number);
		}else{
			alert('인원선택은 총 8명까지 가능합니다.');
		}
		
		// 인원수가 0이상이고, 인원수만큼 좌석을 클릭한 경우 결제버튼 활성화
		if(number>0 && number==clicked){
			$('#btn_booking_pay').prop('disabled', false);
		}else{
			$('#btn_booking_pay').prop('disabled', true);
		}
		
	});
	
	$('.seat').click(function(){
		let selectedSeat = $(this).attr('data-num');
		
		if($(this).hasClass('selected')) { // 이미 선택한 좌석인 경우 취소
	        $(this).removeClass('selected');
			
	        let index = seats.indexOf(selectedSeat);
	        if (index !== -1) {
	            seats.splice(index, 1); // seats 배열에서 해당 좌석 삭제
	            --clicked;
	            $('#my_selected_seat'+(clicked + 1)).text('-');
	            $('#my_selected_seat'+(clicked  + 1)).css('background-color', 'transparent');

				$('#money_area').text((clicked*12000).toLocaleString());
				$('#res_seats').val(seats.toString());
	        }
	    } else if(clicked < number) { // 클릭한 좌석이 인원수보다 작은 경우
			$(this).addClass('selected');
			seats.push(selectedSeat);
			
			++clicked;
			$('#my_selected_seat'+(clicked)).text(selectedSeat);
			$('#my_selected_seat'+(clicked)).css('background-color', '#503396');
			
			$('#money_area').text((clicked*12000).toLocaleString());
			
			$('#res_seats').val(seats.toString());
			
		}
		
		// 인원수가 0이상이고, 인원수만큼 좌석을 클릭한 경우 결제버튼 활성화
		if(number>0 && number==clicked){ 
			$('#btn_booking_pay').prop('disabled', false);
		}else{
			$('#btn_booking_pay').prop('disabled', true);
		}
	});
	
	// 이미 예약한 좌석의 경우 button 비활성화 및 css 처리
	const seatsDB = $('#seatsDB').val();

    $('.seat').each(function() {
		let selectedSeat = $(this).attr('data-num');
		console.log(selectedSeat);
		console.log(seatsDB);

        if (seatsDB.includes(selectedSeat)) {
            $(this).prop('disabled', true); // 버튼 비활성화
            $(this).addClass('after');
			$(this).val('');
        }
    });

	// hover css 처리
	$('.seat').hover(
        function() {
            if (number>0 && clicked < number) { // 인원수가 0이상이고, 인원수보다 클릭한 좌석수가 적은 경우 hover css 추가
                $(this).addClass('hovered');
            }
        },
        function() { // 마우스 다른곳으로 옮기면 hover 제거
            $(this).removeClass('hovered');
        }
    );
});