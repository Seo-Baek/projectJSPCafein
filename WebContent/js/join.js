// mypage.jsp
$("#delete_btn").click(function() {
	var no = $("#no").val();
	var s_no = $("#n_no").val();
	$.ajax({
		type : "post", // 데이터 전송 방식(Get, Post 방식)
		url : "delete_member.do", // 파일 주소와 경로
		data : {
			"no" : no
		},
		// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
		success : function(data) {
			if (s_no > 100) {
				jAlert("삭제 성공", "SUCCESS", function() {
					window.top.location.href = data;
				});
			} else {
				jAlert("삭제 성공", "SUCCESS", function() {
					location.href = data;
				});
			}
		},
		error : function() { // 데이터 통신이 실패한 경우
			alert("data error");
		}
	}); // Ajax end
});

$("#logout_btn").click(function() {
	$.ajax({
		type : "post", // 데이터 전송 방식(Get, Post 방식)
		url : "logout.do", // 파일 주소와 경로
		// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
		success : function(data) {
			if (data) { // 존재하는 경우
				jAlert(data, "SUCCESS", function() {
					window.top.location.href = "index.jsp";
				});
			}
		},
		error : function() { // 데이터 통신이 실패한 경우
			alert("data error");
		}
	}); // Ajax end
});

// join.jsp
var flag = false;

function check_pw() {
	var p1 = document.getElementById("pwd1").value;
	var p2 = document.getElementById("pwd2").value;
	var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;

	$("#pwdcheck").hide();

	if (p1 == "" || p2 == "") {
		var warningTxt = '<font color="red">비밀번호를 입력하세요.</font>';
		$("#pwdcheck").text('');
		$("#pwdcheck").show();
		$("#pwdcheck").append(warningTxt);
		flag = false;
	} else if (passwordRules.test(p1) == false) {
		var warningTxt = '<font color="red">비밀번호는 대소문자, 특수기호, 숫자를 포함하여 8자 이상 16자 이하여야 합니다.</font>';
		$("#pwdcheck").text('');
		$("#pwdcheck").show();
		$("#pwdcheck").append(warningTxt);
		flag = false;
	} else if (p1 != p2) {
		var warningTxt = '<font color="red">두 비밀번호가 일치하지 않습니다.</font>';
		$("#pwdcheck").text('');
		$("#pwdcheck").show();
		$("#pwdcheck").append(warningTxt);
		flag = false;
	} else {
		var warningTxt = '<font color="blue">비밀번호가 일치합니다.</font>';
		$("#pwdcheck").text('');
		$("#pwdcheck").show();
		$("#pwdcheck").append(warningTxt);
		flag = true;
	}
}

$("#m_id").keyup(function() {
	$("#idcheck").hide(); // span 태그 idcheck 영역을 숨겨라
	var userId = $("#m_id").val();

	// 입력 길이 체크
	if ($.trim($("#m_id").val()).length < 4) {
		var warningTxt = '<font color="red">아이디는 4자 이상이어야 합니다.</font>';
		$("#idcheck").text(''); // idcheck 영역 초기화
		$("#idcheck").show(); // span 태그 idcheck 영역을 보여줌
		$("#idcheck").append(warningTxt);
		$("#m_id").focus();
		flag = false;
	} else if ($.trim($("#m_id").val()).length > 16) {
		var warningTxt = '<font color="red">아이디는 16자 이하여야 합니다.</font>';
		$("#idcheck").text(''); // idcheck 영역 초기화
		$("#idcheck").show(); // span 태그 idcheck 영역을 보여줌
		$("#idcheck").append(warningTxt);
		$("#m_id").focus();
		flag = false;
	} else {
		$("#idcheck").text(''); // idcheck 영역 초기화
		$("#idcheck").hide();
		flag = false;
	}

});

// 회원가입 폼 중에서 아이디 중복체크라는 버튼에 마우스가 올라갔을 때 호출되는 무명함수
$("#idcheck_btn").click(function() {
	$("#idcheck").hide(); // span 태그 idcheck 영역을 숨겨라
	var userId = $("#m_id").val();

	// 아이디 중복 여부 확인 - Ajax 기술(비동기 통신)
	$.ajax({
		type : "post", // 데이터 전송 방식(Get, Post 방식)
		url : "idcheck.do", // 파일 주소와 경로
		data : {
			"userId" : userId
		},
		// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
		success : function(data) {
			if (data == 1) { // 아이디가 존재하는 경우(중복인 경우)
				var warningTxt = '<font color="red">중복된 아이디 입니다.</font>';
				$("#idcheck").text(''); // idcheck 영역 초기화
				$("#idcheck").show(); // span 태그 idcheck 영역을 보여줌
				$("#idcheck").append(warningTxt);
				$("#m_id").focus();
				flag = false;
			} else { // 아이디가 중복되지 않은 경우
				var warningTxt = '<font color="blue">사용가능한 아이디 입니다.</font>';
				$("#idcheck").text(''); // idcheck 영역 초기화
				$("#idcheck").show(); // span 태그 idcheck 영역을 보여줌
				$("#idcheck").append(warningTxt);
				$("#pwd1").focus();
				flag = true;
			}
		},
		error : function() { // 데이터 통신이 실패한 경우
			alert("data error");
		}
	}); // Ajax end
});

$('.btn_submit').click(
		function() {
			var requiredFlag = true;
			$('.required').each(
					function() {
						if ($(this).is(':text, textarea, select')
								&& $(this).val().length < 1) {
							jAlert("빼먹은거 없어?", "REQUIRED");
							$(this).focus();
							requiredFlag = false;
							return false;
						} else if ($(this).is(':checkbox, :radio')
								&& !$(this).parent().children('.required').is(
										':checked')) {
							jAlert("빼먹은거 없어?", "REQUIRED");
							$(this).focus();
							requiredFlag = false;
							return false;
						}
						;
					});
			if (flag != true) {
				jAlert("경고를 확인하세요", "CHECK");
			}

			if (requiredFlag == true && flag == true) {
				jConfirm("등록하시겠습니까?", "UPLOAD", function(result) {
					if (result == true) {
						$("form").ajaxForm({
							type : "post",
							url : "join_add.do",
							enctype : "multipart/form-data",
							success : function(result) {
								jAlert("성공", "SUCCESS", function() {
									window.location.href = result;
								});
							}
						});
						$("form").submit();
						return true;
					} else if (result == false) {
						alert("보류!");
						return false;
					}
				});
			}
		});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
	center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
	level : 5
// 지도의 확대 레벨
};

// 지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
// 주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
// 마커를 미리 생성
var marker = new daum.maps.Marker({
	position : new daum.maps.LatLng(37.537187, 127.005476),
	map : map
});

// 우편번호 찾기 화면을 넣을 element
var element_layer = document.getElementById('layer');

function closePost() {
	// iframe을 넣은 element를 안보이게 한다.
	element_layer.style.display = 'none';
}

function search_addr() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("extraAddress").value = extraAddr;

			} else {
				document.getElementById("extraAddress").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("address").value = addr;

			geocoder.addressSearch(data.address, function(results, status) {
				// 정상적으로 검색이 완료됐으면
				if (status === daum.maps.services.Status.OK) {

					var result = results[0]; // 첫번째 결과의 값을 활용

					// 해당 주소에 대한 좌표를 받아서
					var coords = new daum.maps.LatLng(result.y, result.x);
					// 지도를 보여준다.
					mapContainer.style.display = "block";
					map.relayout();
					// 지도 중심을 변경한다.
					map.setCenter(coords);
					// 마커를 결과값으로 받은 위치로 옮긴다.
					marker.setPosition(coords)
				}
			});

			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();

			// iframe을 넣은 element를 안보이게 한다.
			// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
			element_layer.style.display = 'none';
		},
		width : '100%',
		height : '100%',
		maxSuggestItems : 5
	}).embed(element_layer);

	// iframe을 넣은 element를 보이게 한다.
	element_layer.style.display = 'block';

	// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	initLayerPosition();
}

// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
function initLayerPosition() {
	var width = 300; // 우편번호서비스가 들어갈 element의 width
	var height = 400; // 우편번호서비스가 들어갈 element의 height
	var borderWidth = 5; // 샘플에서 사용하는 border의 두께

	// 위에서 선언한 값들을 실제 element에 넣는다.
	element_layer.style.width = width + 'px';
	element_layer.style.height = height + 'px';
	element_layer.style.border = borderWidth + 'px solid';
	// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
			+ 'px';
	element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
			+ 'px';
}
