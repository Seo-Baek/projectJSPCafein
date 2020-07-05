// login.jsp
$(function() {
	$('.btn_submit').click(function() {
		
		$("form").ajaxForm({
			type : "post", 
			url : "login.do",
			success : function(data) {
				console.log(data);
				if (data == 1) { // 존재하는 경우
					jAlert("CAFE:in에 오신것을 환영합니다!", "WELCOME", function() {
						window.top.location.href = "index.jsp";
					});
				} else if (data == -1) {
					jAlert("비밀번호를 확인해 주세요.", "ERROR");
				} else if (data == -2) {
					jAlert("회원가입이 필요합니다.", "ERROR");
				} else {
					jAlert("로그인 실패", "ERROR");
				}
			},
			error : function() { // 데이터 통신이 실패한 경우
				alert("data error");
			}
		});$("form").submit();
		
	});

});

function pwd_find() {
	var popupWidth = 500;
	var popupHeight = 300;

	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

	window.open("find_pwd.do", "비밀번호 찾기 이메일 보내기", 'status=no, titlebar=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);

}

// password.jsp
$(function() {
	$("#checkUser").click(function() {
		$("#nullcheck").hide();
		var id = $("#m_id").val();
		var email = $("#m_email1").val();
		
		if (id == "" && email == "") {
			var warningTxt = '<font color="red">아이디와 이메일을 입력하세요.</font>';
			$("#nullcheck").text('');
			$("#nullcheck").show();
			$("#nullcheck").append(warningTxt);
			return false;
		} else if (id == "") {
			var warningTxt = '<font color="red">아이디를 입력하세요.</font>';
			$("#nullcheck").text('');
			$("#nullcheck").show();
			$("#nullcheck").append(warningTxt);
			return false;
		} else if (email == "") {
			var warningTxt = '<font color="red">이메일을 입력하세요.</font>';
			$("#nullcheck").text('');
			$("#nullcheck").show();
			$("#nullcheck").append(warningTxt);
			return false;
		} else if (id != "" && email != "") {
			$("form").ajaxForm({
				type : "post", 
				url : "pwd_get.do",
				success : function(data) {
					console.log(data);
					if (data) { // 존재하는 경우
						 jAlert(data, "SUCCESS", function() {
							 parent.window.close();
					        });
					} else {
						jAlert("조회가 불가능 합니다.", "ERROR");
						return false;
					}
				},
				error : function() { // 데이터 통신이 실패한 경우
					alert("data error");
				}
			});$("form").submit();
			
		}
		
	});
});