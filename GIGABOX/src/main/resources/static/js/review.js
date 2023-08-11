$(function(){
	let rowCount = 10; //20개가 보여지고싶으면 20이라고 명시하면 됨
	let currentPage;
	let count;
	//관람평 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url:'listReview.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,board_num:$('#review_num').val()},
				//key		변수		key		변수			key			변수
			dataType:'json',
			success:function(param){
				//로딩 이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				//관람평수 읽어오기
				displayReplyCount(param);
				
				//관람평 목록 평점(별점)내는 방법 구현해줘야해
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<ul class="detail-info">';
					output += '<li>';
					output += '<img src="../member/viewProfile.do?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">';
					output += '</li>';
					output == '<li>';
					if(item.nick_name){
						output += item.nick_name + '<br>';
					}else{
						output += item.id + '<br>';
					}
					if(item.review_mdate){
						output += '<span class="review_mdate">최근 수정일 : ' + item.review_mdate + '</span>';
					}else{
						output += '<span class="review_date">최근 등록일 : ' + item.review_date + '</span>';
					}
					output += '</li>';
					output += '</ul>';
					output += '<div class="sub-item">';
					output += '<p>' + item.review_content.replace(/\r\n/g,'<br>') + '</p>';
															// /여기 들어가있는 모든 요소를 검색한다는 뜻/g 
										//re_content는 html 불허해서 줄바꿈 처리만 해주면 됨
					if(param.user_num==item.mem_num){
						//로그인 한 회원 번호와 리뷰 작성자 회원번호와 같으면
						output += ' <input type="button" data-num="'+item.review_num+'" value="수정" class="modify-btn">';
						output += ' <input type="button" data-num="'+item.review_num+'" value="삭제" class="delete-btn">';
					}
					output += '<hr size="1" noshade>';
					output += '</div>';
					output += '</div>';
					
					//문서 객체 추가
					$('#output').append(output);
				});
				
				//paging button 처리
				if(currentPage>=Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				//alert('네트워크 오류 발생');
			}
		});
	}
	//다음 리뷰 보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	//리뷰 등록 
	$('#review_form').submit(function(event){
		if($('#review_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#review_content').val('').focus();
			return false;
		}else if($('#review_score').val().trim()==''){
			alert('평점을 입력하세요!');
			$('#review_score').val('').focus();
		}
		
		//입력한 정보 읽기
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'writeReview.do',
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
	});
	
	//리뷰 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#review_score').val('') //관람평 평점 초기화
		$('#review_first .letter-count').text('220/220');
	}
	
	//리뷰 수정 폼 호출
	$(document).on('click','.modify-btn',function(){
		//관람평 번호
		let review_num = $(this).attr('data-num');
		//관람평 내용
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\r\n');
						//부모를 찾아가서 자식 태그 중 p태그를 찾는다     //모든 <br>을 찾아서 \r\n으로 변경한다 . i는 대소문자 구분없이 찾아라 라는 의미
						
		//관람평 수정폼 UI 관람평 평점 추가해야해
		let modifyUI = '<form id="mreview_form">';
		modifyUI += '<input type="hidden" name="review_num" id="mreview_num" value="'+review_num+'">';
		modifyUI += '<textarea row="3" cols="50" name="review_content" id="mreview_content" class="rep-content">'+review_content+'</textarea>'
		modifyUI += '<div id="mreview_first"><span class="letter-count">220/220</span></div>';
		modifyUI += '<div id="mreview_second" class="align-right">';
		modifyUI += ' <input type="submit" value="수정">';
		modifyUI += ' <input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		//이전에 이미 수정하는 관람평이 있을 경우 수정 버튼을 클릭하면 숨김 sub-item을 환원시키고 수정폼을 초기화함
		initModifyForm();
		
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//수정 버튼을 감싸고 있는 div
		$(this).parent().hide(); //직계 부모라서 parent
		
		//수정폼을 수정하고자 하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI); //부모들을 검색해야하기때문에 parents
		
		//입력한 글자수 셋팅
		let inputLength = $('#mreview_content').val().length;
		let remain = 220 - inputLength;
		remain += '/220';
		
		//문서 객체에 반영
		$('#mreview_first .letter-count').text(remain);
		
	});
		
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//리뷰 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mreview_form').remove();
	}
	
	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>220){//220자를 넘어선 경우
			$(this).val($(this).val().substring(0,200));
		}else{//300자 이하인 경우
			//남은 글자수 구하기
			let remain = 200 - inputLength;
			remain += '/200';
			if($(this).attr('id')=='review_content'){
				//등록 폼 글자수
				$('#review_first .letter-count').text(remain);
			}else{
				//수정 폼 글자수
				$('#mreview_first .letter-count').text(remain);
			}
		}
		
	});
	
	//리뷰 수정
	$(document).on('submit','#mreview_form',function(event){
		if($('#mreview_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#mreview_content').val('').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateReview.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result=='success'){
					//수정한 내용 처리
					$('#mreview_form').parent().find('p').html($('#mreview_content').val().replace(/</g,'&lt;')
					.replace(/>/g,'&gt;').replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>'));
					//최근 수정일 처리
					$('#mreview_form').parent().find('.review_mdate').text('최근 수정일 : 5초미만');
					//수정폼 초기화
					initModifyForm();
				}else if(param.result=='wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('관람평 수정 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
		
	});
	
	//관람평 삭제
	$(document).on('click','.delete-btn',function(){
		//관람평 번호
		let review_num = $(this).attr('data-num');
		//서버와 통신
		$.ajax({
			url:'deleteReview.do',
			type:'post',
			data:{review_num:review_num},
				//key(식별자) value(변수)
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제 완료');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('관람평 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
	});
	
	//관람평수 표시
	function displayReviewCount(data){
		let count = data.count;
		//문서 객체에 추가
		$('#output_reviewcount').text(count);
	}
	
	
	//초기 데이터(목록) 호출
	selectList(1);

});