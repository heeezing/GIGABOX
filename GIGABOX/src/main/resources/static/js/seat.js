$(function(){
	let number = 0; // 인원수
	let seats = []; // 선택한 좌석
	let clicked = 0; // 선택된 좌석 개수
	
	$('.down').click(function(){
		if(number>0){ // 인원수가 0명 이상인 경우 빼기
			--number;
		}
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
			}
		}
		$('.number').val(number);
		$('.person').text(number);
	});
	
	$('.up').click(function(){
		if(number<8){
			++number;
			$('.number').val(number);
			$('.person').text(number);
		}else{
			alert('인원선택은 총 8명까지 가능합니다.');
		}
		
		
	});
	
	$('.seat').click(function(){
		if(clicked<number){
			let selectedSeat = $(this).attr('data-num');
			$(this).addClass('selected');
			
			++clicked;
			$('#my_selected_seat'+(clicked)).text(selectedSeat);
			$('#my_selected_seat'+(clicked)).css('background-color', '#503396');
			
			$('#money_area').text((clicked*12000).toLocaleString());
			
			seats += selectedSeat;
		}
	});
	
	$('#pay').click(function(){
		let sch_num = $('#sch_num').val();
		location.href = "/reservation/saveSeats.do?seats=" + seats + "&sch_num=" + sch_num;
	});
	
	
});