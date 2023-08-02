$(function(){
	//MyPage 프로필 사진 등록 및 수정
	//수정 버튼 이벤트 처리
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();
	})
	
	//처음 화면에 보여지는 이미지 읽기
	let photo_path=$('.my-photo').attr('src');
	let my_photo;//업로드하고자 선택한 이미지 저장
	$('#upload').change(function(){//change는 파일 선택을 하면 발생하는 것
		my_photo = this.files[0];
		if(!my_photo){
			//업로드한게 없으면 기본 이미지가 보인다.
			$('.my-photo').attr('src',photo_path);
			return;
		}
		
		if(my_photo.size > 1024*1024){
			alert(Math.round(my_photo.size/1024)+'kbyte(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',photo_path);
			return;
		}
		
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		//다 읽어왔으면 미리보기 처리
		reader.onload=function(){
			$('.my-photo').attr('src',reader.result);
		};
	});
	
	//파일 업로드 처리
	$('#photo_submit').click(function(){
		if($('#upload').val()==''){
			alert('파일을 선택하세요');
			$('#upload').focus();
			return;//submit버튼이면 return false지만 이거는 그냥 button임
		}
		//서버에 파일 전송
		let form_data = new FormData();
		form_data.append('upload',my_photo);//첫번째 인자에 접근해서 정보를 읽어옴
		
	})
	
	
	
})









