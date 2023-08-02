$(function(){
	
	//이미지 미리 보기
	//1.처음 화면에 보여지는 기존 DB 이미지 저장
	let photo_path = $('.sn-photo').attr('src');
	//2.새로 선택한 이미지 저장
	let new_photo;
	$('#upload').change(function(){
		new_photo = this.files[0];
		//새 이미지를 선택 안 했을 경우 (선택하려다 취소)
		if(!new_photo){ 
			$('.sn-photo').attr('src',photo_path);
			return;
		}
		//파일 용량이 지정한 범위를 넘을 경우
		if(new_photo.size > 1024*1024){
			alert(Math.round(new_photo.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.sn-photo').attr('src',photo_path);
			$(this).val(''); //선택한 파일 정보 지우기
			return;
		}
		
		let reader = new FileReader();
		reader.readAsDataURL(new_photo);
		reader.onload=function(){
			$('.sn-photo').attr('src',reader.result);
			$('#file_detail').empty();
		};
		
	});//end of change
	
	
	//submit 유효성 체크
	$('#update_form').submit(function(){
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
		if($('#sn_info').val().trim()==''){
			alert('설명을 입력하세요!');
			$('#sn_info').val('').focus();
			return false;
		}
		
		let choice = confirm('수정하시겠습니까?');
		if(choice){
			//히스토리를 지우면서 이동
			location.replace('${pageContext.request.contextPath}/snack/admin_list.do');
		}else{
			return false;
		}
	}); //end of submit

});