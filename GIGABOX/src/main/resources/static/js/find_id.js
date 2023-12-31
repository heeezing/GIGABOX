$(function () {
		
	    const modal = document.getElementById("modal");
	    const btnModal = document.getElementById("find_id");
	
	    btnModal.addEventListener("click", e => {
	        modal.style.display = "flex";
	    });
	
	    const closeBtn = modal.querySelector(".close-area");
	    closeBtn.addEventListener("click", e => {
	        modal.style.display = "none";
	    });
	
	    modal.addEventListener("click", e => {
	        const evTarget = e.target;
	        if(evTarget.classList.contains("modal-overlay")) {
	            modal.style.display = "none";
	        }
	    });
	
	
	$('#find_id').click(function(){
		var name = $('#name').val();
	    var phone = $('#phone').val();
	    if($('#name').val().trim()=='' || $('#phone').val().trim()==''){
			alert('이름과 전화번호 모두 입력하세요');
			$('#name').val('').focus();
			return;
		}
	    
	    console.log("name:", name);
	    console.log("phone:", phone);
	    
	    $.ajax({
	        url: "/find_id",
	        type: "post",
	        data: {"name": name, "phone": phone},
	        dataType: "json",
	        success: function (param) {
	            if(param.result == "null"){
	                $('#id_value').text("일치하는 회원정보가 없습니다 !");
	                $('#name').val('');
	                $('#phone').val('');
	            } else {
	                $('#id_value').text(param.result);
	                $('#name').val('');
	                $('#phone').val('');
	            }
	        },
	        error: function(){
	            alert('에러입니다');
	        }
		})
	})
});