//영화api
$(document).ready(function(){
	let movieArray = [];
	
	//ajax호출
	$.ajax({
	type:"get",
	url:"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=Y&listCount=10&sort=prodYear,1&releaseDts=20230501&releaseDte=20230802&type=%22%EA%B7%B9%EC%98%81%ED%99%94%22&ServiceKey=7C19X7UCO798503H925F",
	data:{},
	success:function(param){
		let movie = param['KmdbApi']['row']
		for(let i=0; i<rows.length; i++){
			let title = rows[i]['title']
			let titleEng = rows[i]['titleEng']
			let directorNm= rows[i]['directorNm']
			let actorNm = rows[i]['actorNm']
			let nation = rows[i]['nation']
			let company = rows[i]['company']
			let plotText = rows[i]['plotText']
			let runtime = rows[i]['runtime']
			let rating = rows[i]['rating']
			let genre = rows[i]['genre']
			let releaseDate = rows[i]['releaseDate']
			let posters = rows[i]['posters']
			let stlls = rows[i]['stlls']
			let vodUrl = rows[i]['vodUrl']
		}
	},
	error:function(){
		
	}
});
});



