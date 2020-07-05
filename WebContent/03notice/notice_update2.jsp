<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cafe :in 정보공유</title>
<style type="text/css">
	
.title { 

	border-top:1px solid gray;
	margin: 3%;
 } 
 .table-line{
 	border-top: 1px solid #ddd;
 	border-bottom: 1px solid #ddd;
 }
 #filediv{
 display: block;
  padding: 9.5px;
  margin: 0 0 10px;
  font-size: 13px;
  line-height: 1.42857143;
  color: #333333;
  word-break: break-all;
  word-wrap: break-word;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  border-radius: 4px;
  }
</style>
<link rel="stylesheet" href="css/bootstrap-3.4.1.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<link rel="stylesheet" href="css/bootstrap-3.4.1.css">
 <script src="https://kit.fontawesome.com/74c225bc71.js" crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
  
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<!-- summernote 스타일 관련 cdn -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.css" rel="stylesheet">
<!-- summernote 자바스크립트 cdn -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.js"></script>
<!-- summernote 한글 관련 cdn -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/lang/summernote-ko-KR.min.js"></script>
</head>
<body>

	<div class="container" style="margin-bottom: 2%;">
		<div class="row" align="center">
			<div class="col-xs-2 col-sm-2 col-md-2 "></div>
			<div class="col-xs-8 col-sm-8 col-md-8 ">
				<hr width="100%" class="title" />
					<h2>공지사항 글쓰기 폼 페이지</h2>
				<hr width="100%" class="title" />
			</div>
		</div>
		<br /> 
		
		<br /><br />
		<div class="row" align="center">
			<div class="col-xs-1 col-sm-1 col-md-1 "></div>
			<div class="col-xs-10 col-sm-10 col-md-10 ">
			<form action="<%=request.getContextPath() %>/modify_notice.do" method="post" id="frm">
				<input type="hidden" name="mno" value="${userNo }"/>
				<input type="hidden" name="mname" value="${userName }" />
				<input type="hidden" name="board_no" value="${Cont.getBoard_no() }" />
				
				<div align="left">
				<pre><label>제목 : </label>    <input type="text" name="title" required="required"
				value="${Cont.getBoard_title() }""			class="required"id="title"		style="width: 70%;"/></pre>
				<div align="left" id="filediv">
				<label>썸네일 선택 </label>
				<div style="margin-left: 3%;"><input style="width:60%;"type="file" name="file" id="file"
				placeholder="썸네일로 사용할 이미지를 선택하세요."/></div>
				<div align="center"><input type="button" id="fileUp" value="이미지 전송"/></div>
				<div id="showLog" class="hide"></div>
				</div>
				<textarea rows="10" cols="30" class="form-control" required="required"
						class="required"name="cont" id="myEditor"
					>${Cont.getBoard_cont() }</textarea>
				
				<div class="row" align="center">
					<div class="col-md-8 col-md-offset-2" style="display: none;">
						<input type="text" id="thumbnail"name="thumbnail" value="${Cont.getBoard_file() }"
							style="width: 80%;" />
					</div>
				</div>
				<br />
				<div class="col-xs-12 col-md-12"align="center">
				<label>노출여부 : &nbsp;</label><input type="radio" name="show" id="show" value="노출"/>노출&nbsp;&nbsp;
					<input 
					type="radio" name="show" id="hide" value="비노출" checked />비노출<br />
					<br />
				 <input type="button" id="savebutton" value="글쓰기" />
				 <input type="reset" value="재작성" onclick="reset()" />
				 </div>
 			</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#myEditor').summernote({
		placeholder: '예쁜 마음으로 주제에 맞는 글을 작성해주세요!',
		height: 600,
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ],
		focus: true,
	    lang: 'ko-KR',
		callbacks: {
			onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	sendFile(files[i], this);
	            	}
	            }
	        }
		
	});
});

$(function(){
	let isfile = $("#thumbnail").val();
	if(isfile != ''){
		var warningTxt = '<img src="${dto.getBoard_file()}" /><font color="blue">현재 업로드 된 썸네일이 있습니다.</font>';
		$("#showLog").text('');	// idcheck 영역 초기화
		$("#showLog").attr('class','show');	// span 태그 idcheck 영역을 보이게 하자.
		$("#showLog").append(warningTxt);
		
	}
});
	
	let mname = document.getElementsByName("mname")[0].value;
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: 'uploadFile.do?mname='+mname,
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
        		let file_name = img_name;
          		$(el).summernote('editor.insertImage', img_name);
    
        	},
        	error: function(){
        		alert('save error');
        		}
        	
      	});
      
	}
	
	$("#fileUp").click(function(){
		var form = $("#frm")[0];
		console.log($("#frm")[0]);
		var form_data = new FormData(form);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: 'uploadFile.do?mname='+mname,
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(img_name) {
        		console.log(img_name);
        		$('#thumbnail').attr('value',img_name);   
        		var warningTxt = '<font color="blue">정상 업로드 되었습니다.</font>';
				$("#showLog").text('');	// idcheck 영역 초기화
				$("#showLog").attr('class','show');	// span 태그 idcheck 영역을 보이게 하자.
				$("#showLog").append(warningTxt);
				return false
    
        	},
        	error: function(){
        		$('#thumbnail').attr('value',file_name);   
        		var warningTxt = '<font color="red">실패하였습니다.</font>';
				$("#showLog").text('');	// idcheck 영역 초기화
				$("#showLog").attr('class','show');	// span 태그 idcheck 영역을 보이게 하자.
				$("#showLog").append(warningTxt);
				return false
        		}
        	
      	});
		
	});
	
	$("#reset").click(function(){
		console.log('어떻게이것조차안되지?');
	 	$("#title").val('').focus(); 

		
	});
	
	

	

 $('#savebutton').click(
        function() {
           var requiredFlag = true;
           $('.required').each(
        		   function() {
                       var requiredFlag = true;
                       $('.required').each(
                             function() {
                                if ($(this).is(':text, textarea, select')
                                      && $(this).val().length < 1) {
                                   alert('글 제목과 글내용은 필수사항입니다.');
                                   $(this).focus();
                                   requiredFlag = false;
                                   return false;
                                } else if ($(this).is(':checkbox, :radio')
                                      && !$(this).parent().children(
                                            '.required').is(':checked')) {
                                   alert('빼먹은거 없어?');
                                   $(this).focus();
                                   requiredFlag = false;
                                   return false;
                                }
                                ;
                             });
           if (requiredFlag == true && confirm('등록하시겠습니까?')) {
        	   let thumbnail = $("#thumbnail").val();
        	   if(thumbnail == null){
        		   thmbnail = "";
        	   }
              $("form").submit();
              return true;
           }
        }); 
           
    });
	
</script>
</body>
</html>