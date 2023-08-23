$(function(){
	let list = ""
	
	function select(){
		alert("작업 시작");
		alert($('#eventResult').val());
		alert($('#method').val());
		alert($('#selectNum').val());
        //서버와 통신
        $.ajax({
            url:'randomSelect.do',
            type:'post',
            data:{event_num: $('#eventResult').val(),method:$('#method').val(),selectNum:$('#selectNum').val()},
            dataType:'json',
            success:function(param){
					$("#test").html(param);
					list = param;
                /*//댓글 목록
                $(param.list).each(function(index,item){
               	
           			let output = '<li>';
                	output += '<a href="../event/detail.do?event_num='+item.event_num+'" data-netfunnel="N" class="eventBtn" title="'+item.title+'">';
                    output += '<p class="cate">'+item.category_detail_name+'</p>'
                    output += '<p class="img"> <img src="../event/imageView.do?thumb='+ item.event_num +'&thumb_type=2" alt="'+item.title+'"></p>';
                    output += '<p class="tit">';
                    output += item.title;
                    output += '</p>';
                    output += '<p class="date">';
                    output += item.event_start+' ~ '+item.event_end;
                    output += '</p>';
               		output += '</a>';
           			output += '</li>';
        			output += '</ul>';
   					
                    $('#output').append(output);
                });		*/
				alert("작업 완");
            },
            error:function(){
                alert('네트워크 오류 발생');
            }

        });
    }
});