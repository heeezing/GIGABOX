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
    $('#openrwButton').click(function(event){
		if($('#review_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#review_content').val('').focus();
			return false;
		}else if($('input[name="rating_score"]').val().trim() == ''){
			alert('평점을 입력하세요!');
			$('#rating_score').val('').focus();
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
					//폼 초기화
					initForm();
					//관람평 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글을 다시 호출함
					selectList(1);
				}else{
					alert('관람평 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
		closeModal();
	});
	});


