$(document).ready(function(){
	$('#insertApi').click(function(){
		$.ajax({
		type:"post",
		url:"saveMovies.do",
		dataType:'json',
		success:function(param){
			if(param.result == 'success'){
				alert('영화 불러오기가 성공했습니다.');
				history.go(0);
			}else if(param.result == 'logout'){
				alert('로그인 후 이용 가능합니다.');
			}else{
				alert('영화 불러오기 오류 발생');
			}
		},
		error:function(){
			alert('영화 정보 불러오기 중 네트워크 오류 발생');
		}
	});
		
	});
});