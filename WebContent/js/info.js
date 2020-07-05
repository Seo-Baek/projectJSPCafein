
function include(FileDir) {
    var includejs = document.createElement("script");
    includejs.type = "text/javascript";
    includejs.src = FileDir;
    document.head.appendChild(includejs);
}

include("https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js");
include("https://code.jquery.com/jquery-3.4.1.min.js");


// list_view.jsp
function genre_check() {
	
	var popupWidth = 400;
	var popupHeight = 190;

	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

	window.open("genre_choice.do", "게시글 종류 결정", 'status=no, titlebar=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
	
}

function closeLayer() {
	// iframe을 넣은 element를 안보이게 한다.
	element_layer.style.display = 'none';
}

function searchList() {
	var find_name = $("#find_name").val();
	$("#find_name").val('');
	if(find_name != ""){ 
		listview.location.href = "search_list.do?find_name=" + find_name;
	}
	else{ 
		jAlert("검색할 단어를 입력하세요", "ERROR"); 	
	}

}

// list_genre.jsp
function choiceOk() {

	let genre = f.genre.value;

	opener.location.href = "info_writecont.do?genre=" + genre;

	parent.window.close(); // 선택 후 윈도우창 닫기
}

// info_cont.jsp
function map() {
	var add = $("#add").val();
	window.open("https://www.google.co.kr/maps/place/" + add, "지도보기",
			"width=700,height=700");
	// 자바스크립트에서 window 객체의 open()메서드로 새로운 공지창을 만듬
	// 폭이 450,높이 150 인 새로운 공지창을 만듬.
}

$(function() {
	$("#delete_btn").click(function() {
		var no = $("#no").val();
		var genre = $("#genre").val();
		$.ajax({
			type : "post", // 데이터 전송 방식(Get, Post 방식)
			url : "delete_choice.do", // 파일 주소와 경로
			data : {
				"no" : no,
				"genre" : genre
			},
			// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
			success : function(data) {
				if (data == 1) { // 존재하는 경우
					 jAlert("삭제 성공", "SUCCESS", function() {
				            window.location.href = "info_list.do?";
				        });
				} else {
					jAlert("삭제 실패", "ERROR");
					return false;
				}
			},
			error : function() { // 데이터 통신이 실패한 경우
				alert("data error");
			}
		}); // Ajax end
	});
});


