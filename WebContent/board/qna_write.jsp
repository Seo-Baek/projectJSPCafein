<%@ page import="com.info.model.member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap_3.3.2.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script type="text/javascript">
$(function() {
	   $('.btn_submit').click(function() {
	      
		   var form = document.writeform;
		   var requireFlag=true;
		   
			 if(form['cont'].value==""){
			   jAlert("내용을 적어주세요","required");
			   form['cont'].focus();
			   requiredFlag = false;
               return false;
		   }
		   else if(form['title'].value==""){
			   jAlert("제목을 적어주세요","required");
			   form['title'].focus();
			   requiredFlag = false;
               return false;
		   }
		   else if(form['pwd'].value==""){
			   jAlert("비밀번호를 적어주세요","required");
			   form['pwd'].focus();
			   requiredFlag = false;
               return false;
		   }
	    if(requireFlag==true){
	    		$("form").ajaxForm({
	         type : "post", 
	         url : "qna_write_ok.do",       // 이 JSP파일 안에 있는 정보를 넘길 경로
	         success : function(data) {
	            console.log(data);
	            if (data == 1) { // 존재하는 경우
	               jAlert("게시물 추가 성공", "SUCCESS", function() {
	                  window.location.href = "qna_list.do";  // 경고창을 띄운 후 돌아갈 경로
	               });
	            }  else {
	               jAlert("게시물 추가 실패~~~", "ERROR");
	            }
	         
	         },
	         error : function() { // 데이터 통신이 실패한 경우
	            alert("data error");
	         }
	      });
	    }$("form").submit();
	   });
	 
	});








</script>

<style type="text/css">
table {
	border-top: 1px solid #222;

}

tr{
	height: 27pt;


}

th {

	border-bottom: 1px solid #e7e7e7;
	padding :0 0 0 1.5%;

}


.line {
	width: auto;
	border-bottom: 1px solid #e7e7e7;
	font-size: 14px;
}

.detail {
	min-height: 70px;
	margin: -1px 0 0;
	padding: 30px 10px 35px 10px;
	line-height: 160%;
	border-bottom: 1px solid #222;
}

.contbtn {
	width: auto;
	padding: 8px 0 8px 10px;
}

textarea {
	width: 100%;
	height: 300px;
	border: none;
	outline: none;
}

 h1 {
  text-align:left;

  }
</style>
</head>
<body style="width: 96%">

 <div class="row" align="center">
 <div class="col-xs-1 col-sm-1 col-md-1"></div>
   <div class="col-xs-8 col-sm-3 col-md-8" align="left" style="margin-bottom: 2%;"> 
      <h1 >Q&A</h1>
      </div>
    </div>
      <form name=writeform method="post"action="<%=request.getContextPath()%>/qna_write_ok.do" enctype="multipart/form-data">
    <div class="row" align="center">
            <div class="col-xs-1 col-sm-2 col-md-2 col-lg-1"></div>
            <div class="col-xs-10 col-sm-8 col-md-8 col-lg-10">
				<table border="0" cellspacing="0" style="width: 100%;">
					<tr >
						<th style="margin-left:2%">Subject</th>
						<td class="line">
								<input type="text" name="title"  style="width:80%;" required/>
						</td>
					</tr>
					<tr>
						<th>Name</th>
						<td class="line"><input type="text" name="writer" value="${ MemberDAO.getInstance().getMember( sessionScope.mno ).getM_nickname() }" readonly required/></td>
					</tr>
					<tr>
						<td colspan="2" class="detail"><textarea name="cont" placeholder="문의하기 글 작성을 통해 문의를 주시면 24시간 안에 답변 도와드리겠습니다. "  required></textarea></td>
					</tr>
					<tr>
						<th>File</th>
						<td class="line"><input type="file" name="file" /></td>
					</tr>
					<tr>
						<th>Password</th>
						<td class="line"><input type="password" name="pwd"   required/></td>
					</tr>
	
					<tr>
						<td colspan="2" class="contbtn">
						<input type="button" class="btn_submit btn btn-defult" value="등록"  style="margin-right: 0.4%; " />
						<input type="reset" class="btn btn-defult" value="재작성" /> 
					    <input type="button" class="btn btn-defult" value="목록"onclick="location.href='qna_list.do'"style="float: right;" />
					    </td>
					</tr>
	
				</table>
			</div>
	</div>
		</form>
</body>
</html>



