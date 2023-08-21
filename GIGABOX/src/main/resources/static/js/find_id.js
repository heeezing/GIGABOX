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
	    
	    console.log("name:", name);
	    console.log("phone:", phone);
	    
	    $.ajax({
	        url: "/find_id",
	        type: "post",
	        data: {"name": name, "phone": phone},
	        dataType: "json",
	        success: function (param) {
	            if(param.result == "null"){
	                $('#id_value').text("회원 정보를 확인해주세요!");
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