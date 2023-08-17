$(function(){
	// 처음 항목을 클릭된 상태로 표시
	if($('.th-name').length > 0){
		$('.th-name').first().click();
	}
	
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
	// 오늘 날짜가 클릭된 상태로 표시
	if($('.date-button').length > 0){
		$('.date-button').first().click();
	}
});

// 극장 번호
let selectedTh_num;

// 극장 선택 함수
function selectTheater(prop){
	// 클릭된 항목에 on 클래스 추가
	$(prop).addClass('on');
	// 다른 항목에서 on 클래스 제거
	$(prop).parent().siblings().children().removeClass('on');
	
	// 극장 번호
	let th_num = $(prop).attr('data-num');
	selectedTh_num = th_num;
	
	// 오늘 날짜가 클릭된 상태로 표시
	if($('.date-button').length > 0){
		$('.date-button').first().click();
	}
	
	
	// 서버와 통신
	$.ajax({
		url:'/theater/selectTheater.do',
		type:'post',
		data:{th_num:th_num},
		dataType:'json',
		success:function(param){
			$('#info_title').text(param['th_name']);
			$('#info_image').attr('src', '/theater/photoViewByTh_num.do?th_num='+param['th_num']);
			$('#theater_name').text(param['th_name']);
			$('#theater_address').text(param['th_address']);
			$('#theater_info').html('문의사항 <br>' + param['th_phone']);
		},
		error:function(){
			alert('네트워크 오류 발생');
		}
	});
	
}

// 날짜 버튼 선택 함수
function selectDate(prop){
	// 클릭된 항목에 on 클래스 추가
	$(prop).addClass('on');
	// 다른 항목에서 on 클래스 제거
	$(prop).siblings().removeClass('on');
	
	// 서버와 통신
	$.ajax({
		url:'/theater/getScheduleList.do',
		type:'post', 
		data:{th_num: selectedTh_num, sch_date: $(prop).attr('data-num')},// 상영시간표 목록 보기
		dataType:'json',
		success:function(param){
			//처음 호출시는 해당 class의 div의 내부 내용을 제거
			$('#schedule_list_area').empty();
			
			// 이전에 나타난 영화와 상영관 정보를 추적하기 위한 변수 초기화
			let prevMovieTitle = null;
			let prevHallNum = null;
			let GroupOutput = '';
			
			$(param.scheduleList).each(function(index, item) {
			    if (item.m_title != prevMovieTitle) {
			        if (prevMovieTitle !== null) {
			            // 이전 그룹 정보 마무리
						GroupOutput += '</tr>';
			            GroupOutput += '</table>';
			            GroupOutput += '</div>';
			            GroupOutput += '</div>';
			        }
			
			        // 새로운 그룹 시작
			        GroupOutput += '<div class="schedule-box">';
			        GroupOutput += '<div class="movie-name-area">';
			        GroupOutput += '<a href="/movie/movieDetail.do?movie_num=' + item.movie_num + '" class="movie-name">' + item.m_title + '</a>';
			        GroupOutput += '<p class="information"><span>상영중</span> / 상영시간 130분</p>';
			        GroupOutput += '</div>';
					GroupOutput += '<div class="hall-schedule-box">';
					GroupOutput += '<div class="hall-type">';
			        GroupOutput += '<p class="hall-name">' + item.hall_name + '</p>';
			        GroupOutput += '<p class="seats">' + item.seats + '석</p>';
			        GroupOutput += '</div>';
					GroupOutput += '<table class="schedule-time">';
					GroupOutput += '<tr>';
			    }

				if(item.m_title == prevMovieTitle && item.hall_num != prevHallNum){
					GroupOutput += '</tr>';
					GroupOutput += '</table>';
		            GroupOutput += '</div>';
					
					GroupOutput += '<div class="hall-schedule-box">';
					GroupOutput += '<div class="hall-type">';
			        GroupOutput += '<p class="hall-name">' + item.hall_name + '</p>';
			        GroupOutput += '<p class="seats">' + item.seats + '석</p>';
			        GroupOutput += '</div>';
					GroupOutput += '<table class="schedule-time">';
					GroupOutput += '<tr>';
				}
		        
			    // 상영 시간 정보 추가
			    GroupOutput += '<td class="hoverable">';
				GroupOutput += '<a href="/reservation/seat.do?sch_num=' + item.sch_num + '" class="seatForm">';
			    GroupOutput += '<div class="hidden-text">' + item.sch_start + '~' + item.sch_end + '</div>';
			    GroupOutput += '<p class="time">' + item.sch_start + '</p>';
			    GroupOutput += '<p class="remain-seats">' + item.remain + '석</p>';
			    GroupOutput += '</a>';
			    GroupOutput += '</td>';
			
			    // 현재 영화와 상영관 정보를 이전 정보로 업데이트
			    prevMovieTitle = item.m_title;
			    prevHallNum = item.hall_num;
			});
			
			// 마지막 그룹 정보 마무리
			if (prevMovieTitle !== null && prevHallNum !== null) {
				GroupOutput += '</tr>';
			    GroupOutput += '</table>';
			    GroupOutput += '</div>';
			    GroupOutput += '</div>';
			}
			
			// 결과를 출력
			$('#schedule_list_area').append(GroupOutput);
			
			// 로그인 안한 경우 좌석선택 페이지로 이동하지 않고, 로그인 페이지로 이동
			$('.seatForm').click(function(event){
			    if(!param.user_num){ // user_num이 없는 경우
			        event.preventDefault(); // 링크 이동을 중단
			        alert('로그인이 필요합니다');
					location.href="/member/login.do";
			    }
			});

		},
		error:function(){
			alert('네트워크 오류 발생');
		}
	});
	
}
