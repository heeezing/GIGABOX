$(function(){
	let photo_path = $('.m-poster').attr('src');
	//업로드하고자 선택한 이미지 저장
	let m_poster;
	$('#poster').change(function(){
		m_poster = this.files[0];
		//선택하려다 취소한 경우
		if(!m_poster){
			$('.m-poster').attr('src',photo_path);
			return;
		}
		//파일 크기 제한
		if(m_poster.size > 1024*1024){
			alert(Math.round(m_poster.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.m-poster').attr('src',photo_path);
			$(this).val('');
			return;
		}
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(m_poster);
		reader.onload=function(){
			$('.m-poster').attr('src', reader.result);
		};
	});

	//submit 유효성 체크
	$('#register_form').submit(function(){
		if($('#m_title').val().trim()==''){
			alert('영화제목을 입력하세요!');
			$('#m_title').val('').focus();
			return false;
		}
		if($('#m_director').val().trim()==''){
			alert('감독명을 입력하세요!');
			$('#m_director').focus();
			return false;
		}
		if($('#m_actor').val().trim()==''){
			alert('배우명을 입력하세요!');
			$('#m_actor').focus();
			return false;
		}
		if($('#m_nation').val().trim()==''){
			alert('제작국가를 입력하세요!');
			$('#m_nation').focus();
			return false;
		}
		if($('#m_company').val().trim()==''){
			alert('제작사를 입력하세요!');
			$('#m_company').focus();
			return false;
		}
		if($('#m_opendate').val().trim()==''){
			alert('개봉일을 입력하세요!');
			$('#m_opendate').focus();
			return false;
		}
		if($('#m_runtime').val().trim()==''){
			alert('상영시간을 입력하세요!');
			$('#m_runtime').focus();
			return false;
		}
		if($('#m_rating').val().trim()==''){
			alert('관람등급을 입력하세요!');
			$('#m_rating').focus();
			return false;
		}
		if($('#m_genre').val().trim()==''){
			alert('장르를 입력하세요!');
			$('#m_genre').focus();
			return false;
		}		
		if($('#poster').val() == ''){
			alert('포스터를 첨부하세요!');
			$('#poster').focus();
			return false;
		}
		if($('#stllimg').val().trim()==''){
			alert('스틸사진을 첨부하세요!');
			$('#stllimg').val('').focus();
			return false;
		}
		if($('#m_vod').val().trim()==''){
			alert('예고편을 첨부하세요!');
			$('#m_vod').val('').focus();
			return false;
		}
	}); //end of submit
	
	//submit 유효성 체크
	$('#Update_form').submit(function(){
		if($('#m_title').val().trim()==''){
			alert('영화제목을 입력하세요!');
			$('#m_title').val('').focus();
			return false;
		}
		if($('#m_director').val().trim()==''){
			alert('감독명을 입력하세요!');
			$('#m_director').focus();
			return false;
		}
		if($('#m_actor').val().trim()==''){
			alert('배우명을 입력하세요!');
			$('#m_actor').focus();
			return false;
		}
		if($('#m_nation').val().trim()==''){
			alert('제작국가를 입력하세요!');
			$('#m_nation').focus();
			return false;
		}
		if($('#m_company').val().trim()==''){
			alert('제작사를 입력하세요!');
			$('#m_company').focus();
			return false;
		}
		if($('#m_opendate').val().trim()==''){
			alert('개봉일을 입력하세요!');
			$('#m_opendate').focus();
			return false;
		}
		if($('#m_runtime').val().trim()==''){
			alert('상영시간을 입력하세요!');
			$('#m_runtime').focus();
			return false;
		}
		if($('#m_rating').val().trim()==''){
			alert('관람등급을 입력하세요!');
			$('#m_rating').focus();
			return false;
		}
		if($('#m_genre').val().trim()==''){
			alert('장르를 입력하세요!');
			$('#m_genre').focus();
			return false;
		}		
		if($('#poster').val() == ''){
			alert('포스터를 첨부하세요!');
			$('#poster').focus();
			return false;
		}
		if($('#stllimg').val().trim()==''){
			alert('스틸사진을 첨부하세요!');
			$('#stllimg').val('').focus();
			return false;
		}
		if($('#m_vod').val().trim()==''){
			alert('예고편을 첨부하세요!');
			$('#m_vod').val('').focus();
			return false;
		}
	}); //end of submit
});