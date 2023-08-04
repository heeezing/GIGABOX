$(function(){
	// 처음 화면에 보여지는 이미지 읽기
	let photo_path = $('.th-photo').attr('src');
	let th_photo; // 업로드하고자 선택한 이미지 저장
	$('#upload').change(function(){
		th_photo = this.files[0];
		if(!th_photo){ // 선택하려다가 취소한 경우
			$('.th-photo').attr('src',photo_path);
			return;
		}
		
		// 이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(th_photo);
		
		reader.onload=function(){
			$('.th-photo').attr('src',reader.result);
		};
	});
	
	// 유효성 체크
	$('#theater_add').submit(function(){
		if($('#th_name').val()==''){
			alert('극장명을 입력하세요');
			$('#th_name').val('').focus();
			return false;
		}
		
		if($('#th_address').val()==''){
			alert('주소를 입력하세요');
			$('#th_address').val('').focus();
			return false;
		}
		
		if($('#th_phone').val()==''){
			alert('전화번호를 입력하세요');
			$('#th_phone').val('').focus();
			return false;
		}
		
		if($('#upload').val()==''){
			alert('파일을 선택하세요');
			$('#upload').focus();
			return false;
		}
	}); // end of add
	
	// 유효성 체크
	$('#theater_update').submit(function(){
		if($('#th_name').val()==''){
			alert('극장명을 입력하세요');
			$('#th_name').val('').focus();
			return false;
		}
		
		if($('#th_address').val()==''){
			alert('주소를 입력하세요');
			$('#th_address').val('').focus();
			return false;
		}
		
		if($('#th_phone').val()==''){
			alert('전화번호를 입력하세요');
			$('#th_phone').val('').focus();
			return false;
		}
		
	}); // end of update
	

});