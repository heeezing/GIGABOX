$(function(){
	// 모달 열기 버튼 클릭 시
	document.getElementById('openrwButton').addEventListener('click', function() {
    document.getElementById('rw-modal').style.display = 'block';
	});
	// 모달 닫기
	function closeModal() {
   		document.getElementById('rw-modal').style.display = 'none';
	}
	// 모달 내에서 평점 선택 시
	document.querySelector('.rating_score').addEventListener('click', function(event) {
    	if (event.target.tagName === 'INPUT') {
        	const ratingValue = event.target.value;
       		document.querySelector('.rating-value').textContent = ratingValue;
    	}
	});
	// 취소 버튼 클릭 이벤트 처리
	$(document).on('click','input[class="review-cancel-btn"]',function(){
          closeModal(); // 모달 닫기
    });
 	// 작성하기 버튼 클릭 시 . 리뷰등록
    $('#review_form2').submit(function(event){
		if($('#review_content2').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#review_content2').val('').focus();
			return false;
		}else if($('input[name="rating_score"]').val().trim() == ''){
			alert('평점을 입력하세요!');
			$('#rating_score2').val('').focus();
			return false;
		}
		
		//입력한 정보 읽기
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'reviewWrite.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('관람평이 작성되었습니다.');
					//폼 초기화
					initForm();
					const movieNum = $('#movie_num').val();
					window.location.href = '../movie/movieDetail.do?movie_num='+ movieNum;
					
				}else{
					alert('관람평 등록 오류 발생');
				}
			},
			error:function(){
				alert('리뷰 작성 네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
		closeModal();
	});
	
	//리뷰 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#rating_score2').val('') //관람평 평점 초기화
		$('#review_first2 .letter-count').text('220/220');
	}
	
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>220){//220자를 넘어선 경우
			$(this).val($(this).val().substring(0,220));
		}else{//300자 이하인 경우
			//남은 글자수 구하기
			let remain = 220 - inputLength;
			remain += '/220';
			if($(this).attr('id')=='review_content2'){
				//등록 폼 글자수
				$('#review_first2 .letter-count').text(remain);
			}
		}
		
	});
	
	//별점을 누르면 점수 표출
	$(document).on('click','input[name="rating_score"]',function(){
		let rating = $(this).val();
		if(rating>0){
			$(this).parents('.rating-wrap').find('.rating-value').text(rating);
		}
	});
	
});

