<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap_3.3.2.css">
<style type="text/css">
 table{
      border-top : 1px solid #222;
      
      
 }

 
 th {
     width:100px;
     padding : 8px 0 8px 15px;
     border-bottom : 1px solid #e7e7e7;
     text-align : left;
     letter-spacing:1px;'
 }
 
.line {
     width:auto;
     padding:8px 0 8px 10px;
     border-bottom:1px solid #e7e7e7;
     font-size : 14px;
 }
 
 .detail  {
     min-height:70px;
     margin:-1px 0 0;
     padding : 30px 10px 35px 10px;
     line-height:160%;
     border-bottom : 1px solid #222;
     font-size : 14px;
     
 }
 
 .contbtn {
         width:auto;
         padding:8px 0 8px 10px;
 }
 
 h1 {
  text-align:left;
 
}

pre{
  background-color:white;
  border:none;
}

</style>
</head>
<body style="width: 96%">

<div class="row"align="center">
 <div class="col-xs-1 col-sm-1 col-md-1"></div>
  <div class="col-xs-8 col-sm-3 col-md-8" align="left" style="margin-bottom: 2%;"> 
 <h1 > Q&A</h1>
   </div>  
 </div>
   <div class="row" align="center">
  <table border="0" cellspacing="0" width="80%"  >
    <c:set var="dto" value="${cont }" />
       <c:if test="${!empty dto }">      <%-- c:if 1번째 --%>
		          <tr >
		             <th >Subject </th>
		             <td class="line"> ${dto.getQna_title()} </td>
		          </tr>
		          <tr >
		              <th>Name</th>
		              <td class="line">${dto.getQna_writer() }</td>
		          </tr>
		          <tr >
		               <th>Date</th>
		                <td class="line">${dto.getQna_date() }</td>
		          </tr>
		               <%--파일이 존재하는 경우에만 파일칸 나타냄. --%>
			          <c:set var="file" value="${dto.getQna_file() }" />
			          <c:if test="${!empty file }">   <%-- c:if 2번째 --%>
			           <tr>
			            <th>File</th>
			            <td  class="line"><a href="./qna_upload/${dto.getQna_file()}" target="_blink">${dto.getQna_file() }</a></td>
			        </tr>  
		        </c:if>   <%-- c:if 2번째 end --%>
		          <tr>
		                 <td colspan="2" class="detail" ><pre>${dto.getQna_cont() }</pre></td>
		         </tr>     
	   </c:if>  <%-- c:if 1번째 end --%>
       <c:if test="${empty dto }">  <%-- c:if 3번째 --%>
		          <tr>
		             <td colspan="2"  align="center">
		                  <h3>검색된 레코드가 없습니다.</h3>  
		              </td>
		           </tr>       
	</c:if> <%-- c:if 3번째 end--%>
      
       <tr >
           <td colspan="2"  class="contbtn" >
               <input type="button" value="수정" class="btn btn-defult" onclick="location.href='qna_edit.do?no=${dto.getQna_no() }&page=${page }'"  style=float:left;margin-right:10px;/> 
               <input type="button" value="삭제" class="btn btn-defult" onclick="location.href='qna_delete.do?no=${dto.getQna_no() }&page=${page}'" style=float:left;margin-right:10px;/>
               <c:if test="${ mnum <= 100 }">
               <input type="button" value="답변" class="btn btn-defult" onclick="location.href='qna_reply.do?no=${dto.getQna_no() }&page=${page}'" style=float:left;/>
               </c:if>
               <input type="button" value="목록" class="btn btn-defult" onclick="location.href='qna_list.do?page=${page}'" style=float:right;>
         </tr>      

      </table>
      
   
       
       


   </div>
</body>
</html>