<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap_3.3.2.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script type="text/javascript">
$(function() {
	   $('.btn_submit').click(function() {
	      
	      $("form").ajaxForm({
	         type : "post", 
	         url : "qna_delete_ok.do",       // 이 JSP파일 안에 있는 정보를 넘길 경로
	         success : function(data) {
	            console.log(data);
	            if (data == 1) { // 존재하는 경우
	               jAlert("게시물 삭제 성공", "SUCCESS", function() {
	                  window.location.href = "qna_list.do";  // 경고창을 띄운 후 돌아갈 경로
	               });
	            } else if (data == -1) {
	               jAlert("비밀번호가 틀립니다. 확인요망.", "ERROR");
	            } else if (data == -2) {
	               jAlert("해당 게시글이 없습니다.", "ERROR");
	            } else {
	               jAlert("게시물 삭제 실패~~~", "ERROR");
	            }
	         },
	         error : function() { // 데이터 통신이 실패한 경우
	            alert("data error");
	         }
	      });$("form").submit();
	      
	   });

	});





</script>
<style type="text/css">

th {
    font-size: 20px;
    text-align:center;


}
gap{
   height:15pt;
}


 tr{
height:30pt;
 text-align: center;
} 


table {
  

    margin:auto;
    border-collapse: separate;
     text-align: center;

}



input::placeholder {
  font-style:italic;
}

 h1 {
  text-align:left;
  
  }
pwd{
width:100%;
}



</style>
</head>
<body>
<div class="row" align="center">
	 <div class="col-xs-1 col-sm-1 col-md-1"></div>
	  <div class="col-xs-8 col-sm-3 col-md-8" align="left" style="margin-bottom: 8%;"> 
       <h1>Q&A</h1>
       </div>  
 </div>

       <form method="post"   action="<%=request.getContextPath() %>/qna_delete_ok.do" >
       
         <div class="row" align="center" style="border:2px solid #e7e7e7; margin:0% 30% 0%;">
         
       <input type="hidden" name="qna_no" value="${no }"   />
       <input type="hidden" name="page" value="${page }" />
       
       <table border="0"  cellspacing="0" style="align:center;">
            <tr></tr>
            <tr style="height:15pt;">
                 <th style="font-size:24px;">삭제하기</th>
             </tr>
             <tr class="gap"></tr>
             <tr>
                 <td style="font-size:14px">비밀번호를 입력하여 주세요.</td>
             </tr>
             <tr >
                 <td class="pwd"><input type="password" name="pwd" placeholder="password" style="width:100%;height:17pt;"></td>
             </tr>
             <tr>
             <td colspan="2" align="center">
	              <input type="button" class="btn_submit btn btn-defult" value="삭제"    />&nbsp; &nbsp; 
	              <input type="reset" class="btn btn-defult" value="정정" />
              </td>
            </tr>  
            <tr>
            </tr>
       </table>
       
        </div>
       
       </form>
      



</body>
</html>