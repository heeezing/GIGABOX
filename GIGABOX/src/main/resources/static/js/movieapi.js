$(document).ready(function(){
/* 영화진흥위원회 api xml로 api가져오려고 시도했던 .. 것 .... 
	let today = new Date() - 1;
	
	$(document).on('click','input[id="insertApi"]',function(){
	//$('#insertApi').click(function(){
		//Json 주소
		//let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1c727846377420949f67237c42cadca5&targetDt=" + today;
		//xml 주소
		let url2 = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=1c727846377420949f67237c42cadca5&targetDt=" + today;
		//ajax통신
		$.ajax({
			type:"GET",
			url: url2,
			suceess : function(data){
				//출력변수
				let str = "";
				
				$(data).find("dailyBoxOffice").each(function(){ //dailyboxoffice를 찾을 때마다 function 수행
					//순위
					str = str + $(this).find("rank").text();
					//영화 이름
					str = str + $(this).find("movieNM").text();
					//개봉일
					str = str + $(this).find("openDt").text() + "<br>";
				});
				//결과 출력
				$('.apipreview').html(str);
			},
			error : function(){
				alert('영화 정보 불러오기 중 네트워크 오류 발생');
			}
		});
	});
*/
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