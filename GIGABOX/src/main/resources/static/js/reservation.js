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
	
});