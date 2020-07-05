
// info_write.jsp

// summernote
$(function() {
	$("#myEditor").summernote({
		lang : "kd-KR",
		height : 300,
		callbacks : {
			onImageUpload : function(files, editor, welEditable) {
				for (var i = files.length - 1; i >= 0; i--) {
					// saveFile(files[0],this);
					sendFile(files[i], this);
				}
			}
		}
	});
	/**
	 * 이미지 파일 업로드
	 */

	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : 'uploadSummernote.do',
			cache : false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(img_name) {
				$(el).summernote('editor.insertImage', img_name);
			},
			error : function() {
				alert('save error');
			}

		});

	}

});

// 글작성
$(function() {

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
									&& !$(this).parent().children('.required')
											.is(':checked')) {
								jAlert("빼먹은거 없어?", "REQUIRED");
								$(this).focus();
								requiredFlag = false;
								return false;
							}
							;
						});
				if (requiredFlag == true) {
					jConfirm("등록하시겠습니까?", "UPLOAD", function(result) {
			            if(result == true) {
			            	$("form").submit();
							return true;
			            } else if(result == false) {
			                alert("보류!");
			                return false;
			            }
			        });
				}
			});

	$("#check_btn")
			.click(
					function() {
						$("#check").hide();
						var coun = $("#coun_name").val();
						if ($.trim($("#coun_name").val()).length < 1) {
							var warningTxt = '<font color="red">나라이름을 입력하세요.</font>';
							$("#check").text('');
							$("#check").show();
							$("#check").append(warningTxt);
							$("#coun_name").focus();
							return false;
						}
						// 중복 여부 확인 - Ajax 기술(비동기 통신)
						$
								.ajax({
									type : "post", // 데이터 전송 방식(Get, Post 방식)
									url : "coun_check.do", // 파일 주소와 경로
									data : {
										"coun" : coun
									},
									datatype : "jsp", // 통신할 문서의 데이터 타입
									// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
									success : function(data) {
										if (data == 1) { // 존재하는 경우(중복인 경우)
											var warningTxt = '<font color="red">이미 등록되어있는 나라 입니다.</font>';
											$("#check").text('');
											$("#check").show();
											$("#check").append(warningTxt);
											$("#coun_name").focus();
											return false;
										} else {
											var warningTxt = '<font color="blue">등록 가능한 나라입니다.</font>';
											$("#check").text('');
											$("#check").show();
											$("#check").append(warningTxt);
											$("#coun_name").focus();
											return false;
										}
									},
									error : function() { // 데이터 통신이 실패한 경우
										alert("data error");
									}
								}); // Ajax end
					});
});

$(function() {
	$("#delete_btn").click(function() {
		$("#dtoFile").val('');
		JAlert("첨부파일 삭제");
		return false;
	});
});