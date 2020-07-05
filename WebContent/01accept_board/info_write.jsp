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
					<h2>정보광장 글쓰기 폼 페이지</h2>
				<hr width="100%" class="title" />
			</div>
		</div>
		<br /> 
		
		<br /><br />
		<div class="row" align="center">
			<div class="col-xs-1 col-sm-1 col-md-1 "></div>
			<div class="col-xs-10 col-sm-10 col-md-10 ">
			<form action="<%=request.getContextPath() %>/write_ok.do" method="post" id="frm">
				<input type="hidden" name="mno" value="${userNo }"/>
				<input type="hidden" name="mname" value="${userName }" />
				
				<div>
				<pre><label>제목 : </label><input type="text" name="title" required="required"
							class="required"id="title"		style="width: 80%;"/> </pre>
				</div>
				<textarea rows="10" cols="30" class="form-control" required="required"
						class="required"name="cont" id="myEditor"
					></textarea>
				<span id="helpBlock" class="help-block">
				마지막으로 입력한 이미지가 썸네일로 제공됩니다.
				</span>
				<div class="row" align="center">
					<div class="col-md-8 col-md-offset-2" style="display: none;">
						<input type="text" id="thumbnail"name="thumbnail"
							style="width: 80%;"readonly />
					</div>
				</div>
				<br />
				 <input type="button" id="savebutton" value="글쓰기" />
				 <input type="reset" value="재작성" onclick="reset()" />
 			</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#myEditor').summernote({
		placeholder: '예쁜 마음으로 주제에 맞는 글을 작성해주세요! &#xF002;',
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
          			$('#thumbnail').attr('value',file_name);          			
           		console.log(file_name);
        	},
        	error: function(){
        		alert('save error');
        		}
        	
      	});
      
	}
	
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