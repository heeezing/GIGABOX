$(function(){
	// 유효성 체크
	$('#hall_add').submit(function(){
		if($('#hall_name').val()==''){
			alert('상영관명을 입력하세요');
			$('#hall_name').val('').focus();
			return false;
		}
		
		if($('#th_num').val()=='0'){
			alert('극장을 선택하세요');
			$('#th_num').focus();
			return false;
		}
		
	}); // end of add
	
	$('#hall_update').submit(function(){
		if($('#hall_name').val()==''){
			alert('상영관명을 입력하세요');
			$('#hall_name').val('').focus();
			return false;
		}
		
		if($('#th_num').val()=='0'){
			alert('극장을 선택하세요');
			$('#th_num').focus();
			return false;
		}
		
	}); // end of update
	

});