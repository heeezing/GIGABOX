$(function(){
	//유효성 체크
	$('#admin_scheduleAdd').submit(function(){
		if($('#movie_num').val()=='0'){
			alert('영화를 선택하세요.');
			$('#movie_num').focus();
			return false;
		}
		if($('#th_num').val()=='0'){
			alert('극장을 선택하세요.');
			$('#th_num').focus();
			return false;
		}
		if($('#hall_num').val()=='0'){
			alert('상영관을 선택하세요.');
			$('#hall_num').focus();
			return false;
		}
		if($('#sch_date').val()==''){
			alert('상영날짜를 입력하세요.');
			$('#sch_date').val('').focus();
			return false;
		}
		if($('#sch_start').val()==''){
			alert('상영시작시간을 입력하세요.');
			$('#sch_start').val('').focus();
			return false;
		}
		if($('#sch_end').val()==''){
			alert('상영종료시간을 입력하세요.');
			$('#sch_end').val('').focus();
			return false;
		}
	});
	
	// 극장 선택 처리
	$('#th_num').change(function() {
        const selectedTheaterId = $(this).val(); // 선택한 극장의 ID
        const hallSelect = $('#hall_num');

        // AJAX 요청으로 선택한 극장에 해당하는 상영관 목록 가져오기
        $.ajax({
           url: `../reservation/getHallsByTheaterId?th_num=${selectedTheaterId}`,
   		   method: 'GET',
            success: function(data) {
                // 기존의 상영관 옵션들을 제거
                hallSelect.empty().append($('<option>', {
                    value: 0,
                    text: '상영관을 선택하세요'
                }));
                // 선택한 극장에 해당하는 상영관 옵션 추가
                $.each(data, function(index, hall) {
                    hallSelect.append($('<option>', {
                        value: hall.hall_num,
                        text: hall.hall_name
                    }));
                });
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
    });

	//빠른예매 - 영화, 극장 버튼
	$('.movie_choice .btn').click(function() {
        $('.movie_choice .btn').removeClass('btn-on');
        $(this).addClass('btn-on');
    });

    $('.theater-choice .btn').click(function() {
		// 극장을 선택하기 전에 영화를 선택하지 않았으면 선택 불가능하게 처리
	    if ($('.movie_choice .btn.btn-on').length === 0) {
	        alert('영화를 먼저 선택해주세요.');
	        return;
	    }

        $('.theater-choice .btn').removeClass('btn-on');
        $(this).addClass('btn-on');

		
    });

	// 날짜
	// 토,일인 경우 button에 클래스 추가
	$('.day-of-week').each(function() {
	    if ($(this).text().trim() == '토') {
	        $(this).parent().addClass('sat');
	    }
		if ($(this).text().trim() == '일') {
	        $(this).parent().addClass('holi');
	    }
	});
	
});