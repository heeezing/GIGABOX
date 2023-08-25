$(function(){
	let rowCount = 10; //20개가 보여지고싶으면 20이라고 명시하면 됨
	let currentPage;
	let count;
	
	
	//예매순위 구하기
	$.ajax({
		url:'reservationRankByMovie.do',
		type:'post',
		data:{movie_num:$('#movie_num').val()},
		dataType:'json',
		success:function(param){
       		 $('.rank').text(param.rank);
		},
		error:function(){
		}
	});
	
	//관람평 수 표시
	$.ajax({
		url:'reviewCount.do',
		type:'post',
		data:{movie_num:$('#movie_num').val()},
		dataType:'json',
		success:function(param){
       		 $('.reviewCount').text(param.reviewCount);
		},
		error:function(){
		}
	});
	
	//관람평 평점 표시
	$.ajax({
		url:'reviewAvg.do',
		type:'post',
		data:{movie_num:$('#movie_num').val()},
		dataType:'json',
		success:function(param){
       		 $('.ratingAvg').text(param.ratingAvg);
		},
		error:function(){
			alert('관람평 평점 표시 네트워크 오류');
		}
	});	
	
	//관람평 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url:'reviewList.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,movie_num:$('#movie_num').val()},
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
				
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<ul class="detail-info">';
					output += '<li>';
					output += '<img src="../member/viewProfile.do?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">'; 
					output += '</li>';
					output += '<li class="nick-name">';
					if(item.nick_name){
						output += item.nick_name + '<br>';
					}else{
						output += item.id + '<br>';
					}
					output += '</li>';
					output += '</ul>';
					//목록에 관람평 점수 보이기
					output += '<div class="reviewbackground">';
					output += '<div class="sub-item-score">';
					output += '<span>' + item.rating_score + '</span>';
					output += '</div>';
					//관람평 내용 보이기
					output += '<div class="sub-item">';
					output += '<p>' + item.review_content.replace(/\r\n/g,'<br>') + '</p>';
															// /여기 들어가있는 모든 요소를 검색한다는 뜻/g 
										//re_content는 html 불허해서 줄바꿈 처리만 해주면 됨
					if(param.user_num==item.mem_num){
						//로그인 한 회원 번호와 리뷰 작성자 회원번호와 같으면
						output += '<div class="modifybtn">';
						output += ' <input type="button" data-num="'+item.review_num+'" data-star="'+item.rating_score+'" value="수정" class="modify-btn">';
						output += ' <input type="button" data-num="'+item.review_num+'" value="삭제" class="delete-btn">';
						output += '</div>'
					}
					//좋아요 버튼
					output += '<div class="favcontainer">';
					output += '<img class="output_fav" id="output_fav' + item.review_num + '" data-num="' + item.review_num + '" data-movie-num = "'+ item.movie_num +'"src="../images/like.png" width="40">';
					output += '<span class="output_fcount" id="output_fcount' + item.review_num + '">'+ item.fav_cnt+'</span>';
					output += '</div>';
					//좋아요 끝
					//신고하기 버튼 
					output += '<div class="button-group">';
					output += '<input type="button" value="신고하기" class="repo_btn" data-num="'+item.review_num+'" data-movie-num="'+ item.movie_num+'">';
					output += '<div id="modal'+item.review_num+'" class="modal">';
					output += '<div class="modal_container">';
					output += '<div class="modal_head"><h2>신고하기</h2></div>';
					output += '<div class="modal_body">';
					output += '<form style="border:none;" id="repo_modal'+item.review_num+'" class="repo-modal" action="writeReport.do" method="post">';
					output += '<input type="hidden" name="review_num" value="'+item.review_num+'">';
					output += '<input type="hidden" name="movie_num" value="'+item.movie_num+'">';
					output += '<input type="hidden" name="mem_num" value="'+item.mem_num+'">';
					output += '<span>정말로 해당 글을 신고하시겠습니까?</span>'
					output += '<div class="modal_btn_group">';
					output += '<input type="button" value="취소" class="repo_cancel">';
					output += '<input type="submit" value="신고하기" class="repo_submit" id="repo_submit'+item.review_num+'">';
					output += '</div>';
					output += '</form>';
					output += '</div>';
					output += '</div>';
					output += '</div>';
					//신고하기 끝
					output += '</div>';
					output += '</div>';
					output += '</div>';
					output += '<hr size="1" noshade>';
					output += '</div>';
					output += '<div class="datecontainer">';
					if(item.review_mdate){
						output += '<span class="review_mdate">최근 수정일 : ' + item.review_mdate + '</span>';
					}else{
						output += '<span class="review_date">최근 등록일 : ' + item.review_date + '</span>';
					}
					output += '</div>';
					
					
					//문서 객체 추가
					$('#output').append(output);
				});
				
				$(param.list).each(function(index,item){
					selectFav(item.review_num,item.movie_num);
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
 	// 작성하기 버튼 클릭 시
    $('.review-btn').click(function(){
		let choice = confirm('관람평은 실관람 이후 작성가능합니다. 기가박스에서 관람하신 경우 [예매내역] 확인 후 이용하실 수 있습니다.');
		if(choice){
			location.href='../board/reservationList.do';
		}
	});
	
	//submit버튼을 누르면 작성이 되어야하는데 이건 마이페이지에서만 예매내역 확인 후 구현되어야해
	/*
	//리뷰 등록 
	$('#review_form').submit(function(event){
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
	
	*/
	
	//리뷰 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#rating_score').val('') //관람평 평점 초기화
		$('#review_first .letter-count').text('220/220');
	}
	
	//리뷰 수정 폼 호출
	$(document).on('click','.modify-btn',function(){
		//관람평 번호
		let review_num = $(this).attr('data-num');
		let rating_score = $(this).attr('data-star');
		//관람평 내용
		let review_content = $(this).parents('.sub-item').find('p').html().replace(/<br>/gi,'\r\n');
						//부모를 찾아가서 자식 태그 중 p태그를 찾는다     //모든 <br>을 찾아서 \r\n으로 변경한다 . i는 대소문자 구분없이 찾아라 라는 의미
						
		let modifyUI = '<form id="mreview_form">';
		modifyUI += '<input type="hidden" name="review_num" id="mreview_num" value="'+review_num+'">';
		//평점 수정폼 시작
		modifyUI += '<div class="rating-wrap align-center">';
		modifyUI += '<fieldset class="rating_score">'; 
		let checked = '';
		for(let i=10;i>0;i--){
			if(i==rating_score){
				checked = 'checked';
			}else{
				checked = '';
			}
			if(i%2==0){
				modifyUI += '<input type="radio" name="rating_score" '+checked+' value="'+i+'" id="mstar'+i+'"/><label for="mstar'+i+'" class="full"></label>';
			}else{
				modifyUI += '<input type="radio" name="rating_score" '+checked+' value="'+i+'" id="mstar'+i+'"/><label for="mstar'+i+'" class="half"></label>';
			}
		}
		
		modifyUI += '</fieldset>';	
		modifyUI += '<span class="rating-value" style="font-size: 40px; font-weight:1000; color: #000;" >'+rating_score+'</span>';		        	
		modifyUI += '<span style="font-size: 14px; font-weight: bold; color: #333; margin-top:25px; margin-left:10px;">&nbsp;/&nbsp; 10</span>';
		modifyUI += '</div>';			        
		//평점 수정폼 끝
		
		modifyUI += '<textarea row="3" cols="50" name="review_content" id="mreview_content" class="review-content">'+review_content+'</textarea>'
		modifyUI += '<div id="mreview_first"><span class="letter-count align-right">220/220</span></div>';
		modifyUI += '<div id="mreview_second" class="align-center">';
		modifyUI += ' <input type="button" class="review-btn review-reset" value="취소" >';
		modifyUI += ' <input type="submit" class="review-btn" value="수정">';
		modifyUI += '</div>';
		//modifyUI += '<hr size="1" noshade width="96%">';
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
	$(document).on('click','.review-reset',function(){
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
			$(this).val($(this).val().substring(0,220));
		}else{//300자 이하인 경우
			//남은 글자수 구하기
			let remain = 220 - inputLength;
			remain += '/220';
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
			url:'reviewUpdate.do',
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
			url:'reviewDelete.do',
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

	//초기 데이터(목록) 호출
	selectList(1);

	//별점을 누르면 점수 표출
	$(document).on('click','input[name="rating_score"]',function(){
		let rating = $(this).val();
		if(rating>0){
			$(this).parents('.rating-wrap').find('.rating-value').text(rating);
		}
	});
	
    // 신고하기 버튼 클릭 이벤트 처리
   $(document).on('click','input[class="repo_btn"]',function(){
		let reviewnum = $(this).attr('data-num');
        $('#modal'+reviewnum).css('display', 'block'); // 모달 창 보이기
    });

    // 취소 버튼 클릭 이벤트 처리
	$(document).on('click','input[class="repo_cancel"]',function(){
          $('.modal').css('display', 'none'); // 모달 창 숨기기
    });
	
	// 신고 폼 제출 이벤트 처리
    $(document).on('submit','.repo-modal',function(event) {
		//repo_modal = $('#repo_modal'+review_num);
        event.preventDefault(); // 기본 제출 동작 막기
		
		let form_data = $(this).serialize();

        $.ajax({
            url: 'writeReport.do',
            type: 'post',
            data:form_data,
            dataType: 'json',
            success: function(param) {
                if(param.result == 'logout'){
					alert('로그인해야 신고할 수 있습니다.');
				}else if(param.result == 'alreadydonereport'){
					alert('이미 신고가 접수되었습니다.');
				}else if(param.result == 'success'){
					alert('신고가 접수되었습니다.');
					history.go(0);
				}else{
					alert('신고 등록 오류 발생');
				}
            },
            error: function() {
                alert('신고 네트워크 오류 발생');
            }
        });

        $('#modal').css('display', 'none'); // 모달 창 숨기기
    });


	//좋아요 읽기
	//좋아요 선택 여부와 선택한 총 개수 표시
	function selectFav(review_num,movie_num){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{review_num:review_num,
				movie_num:movie_num},
			dataType:'json',
			success:function(param){
				console.log(param);
				displayFav(param,review_num);
			},
			error:function(){
				alert('selectFav 오류 발생');
			}
		});
	}//end of selectFav
	
	//좋아요 등록/삭제
	$(document).on('click','img[class="output_fav"]',function(){
		let review_num = $(this).attr('data-num');
		console.log('클릭 : ' + review_num);
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{review_num:review_num,
				movie_num:$(this).attr('data-movie-num')},
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인 후 이용 가능합니다.');
				}else if(param.result=='success'){
					displayFav(param,review_num);
				}else{
					alert('등록시 오류 발생');
				}
			},
			error:function(){
				alert('클릭이벤트 오류 발생');
			}
		});
	});//end of #output_fav click
	
	//좋아요 표시 공통 함수
	function displayFav(param,review_num){
		let output;
		if(param.status=='yesFav'){
			output = '../images/like.png';
		}else if(param.status=='noFav'){
			output = '../images/dontlike.png';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_fav'+review_num).attr('src',output);
		$('#output_fav'+review_num).parent().find('#output_fcount'+review_num).text(param.count);
		
	};//end of displayFav 
	
});



















