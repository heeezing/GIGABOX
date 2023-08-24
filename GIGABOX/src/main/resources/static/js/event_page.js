$(function(){
    let rowCount = 10;
    let currentPage;
    let count;
    //댓글 목록
    function selectList(pageNum){
        currentPage = pageNum;
        
        //서버와 통신
        $.ajax({
            url:'eventEndList.do',
            type:'post',
            data:{pageNum:pageNum,rowCount:rowCount},
            dataType:'json',
            success:function(param){
                count = param.count;

                if(pageNum == 1){
                    //처음 호출시는 해당 ID의 div의 내부 내용물을 제거
                    $('#output').empty();
                }
                
                //댓글 목록
                $(param.list).each(function(index,item){
               	
           			let output = '<li>';
                	output += '<a href="../event/detail.do?event_num='+item.event_num+'" data-netfunnel="N" class="eventBtn" title="'+item.title+'">';
                    output += '<p class="cate">'+item.category_detail_name+'</p>'
                    output += '<p class="img"> <img src="../event/imageView.do?thumb='+ item.event_num +'&thumb_type=1" alt="'+item.title+'"></p>';
                    output += '<p class="tit">';
                    output += item.title;
                    output += '</p>';
                    output += '<p class="date">';
                    output += item.event_start.substr(2)+' ~ '+item.event_end.substr(2);
                    output += '</p>';
               		output += '</a>';
           			output += '</li>';
        			output += '</ul>';
   					
                    $('#output').append(output);
                   
                });
                
                $('#count_number').append(count);
                
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
                alert('네트워크 오류 발생');
            }
            
        });
    }
    
    
    //다음 댓글 보기 버튼 클릭시 데이터 추가
    $('.paging-button button').click(function(){
        selectList(currentPage + 1);
    });

    selectList(1);	
});