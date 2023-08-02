$(function(){
	
	//처음 화면에 보여지는 이미지 읽기
	let photo_path = $('.sn-photo').attr('src');
	//업로드하고자 선택한 이미지 저장
	let sn_photo;
	$('#upload').change(function(){
		sn_photo = this.files[0];
		//선택하려다 취소한 경우
		if(!sn_photo){
			$('.sn-photo').attr('src',photo_path);
			return;
		}
		//파일 크기 제한
		if(sn_photo.size > 1024*1024){
			alert(Math.round(sn_photo.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.sn-photo').attr('src',photo_path);
			$(this).val('');
			return;
		}
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(sn_photo);
		reader.onload=function(){
			$('.sn-photo').attr('src', reader.result);
		};
	});
	
	
	//submit 유효성 체크
	$('#insert_form').submit(function(){
		if($('#sn_name').val().trim()==''){
			alert('상품명을 입력하세요!');
			$('#sn_name').val('').focus();
			return false;
		}
		if($('#sn_detail').val().trim()==''){
			alert('구성을 입력하세요!');
			$('#sn_detail').val('').focus();
			return false;
		}
		if($('#sn_price').val().trim()==''){
			alert('가격을 입력하세요!');
			$('#sn_price').focus();
			return false;
		}
		if($('#upload').val() == ''){
			alert('사진파일을 첨부하세요!');
			$('#upload').focus();
			return false;
		}
		if($('#sn_info').val().trim()==''){
			alert('설명을 입력하세요!');
			$('#sn_info').val('').focus();
			return false;
		}
	}); //end of submit

});