<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap_3.3.2.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<style type="text/css">
.pagination{

	height:27px;
	margin-top:50px;

}

a:link{
   color:black;
   text-decoration: none;
}

a{
    color:black;
    text-decoration: none;
}

a:hover{
    color:#999999;
    text-decoration: none;
}




td {
padding :7px 3px 7px;
height: 27px;
text-align:center;
vertical-align:middle;
border-bottom:1px solid black;


}

.array{
    text-align:left;
    padding-left:20px;
    word-break:break-all;
    width:700px;
}

.array2{
    text-align:right;
    border-bottom:none;
    border-left:none;
    border-right:none;
    
}

.date{
   line-height:14px;
   font-size:12px;
   width:100px;
}

.modi{
    font-size:12px;
     width:0px;
     color:#ff1493;
}

table{
  border-bottom:none;
  border-left:none;
  border-right:none;
}

h1 {
  text-align:left;
}
</style>
</head>
<body style="width: 96%">


  
<div class="row" align="center">
	<div class="col-xs-1 col-sm-1 col-md-1"></div>
   <div class="col-xs-8 col-sm-8 col-md-8" align="left" style="margin-bottom: 2%;"> 
      <h1>Q&A</h1>
     </div> 
   
       <table border="0"  cellspacing="0" width="80%">
            <tr >
                <td >No</td>    <td colspan="2">Subject</td>  <td >Name</td> <td >Date</td> 
            </tr>
            <c:set var="list" value="${List }" />
            
            <c:if test = "${!empty list }" >
                 <c:forEach items="${list }"  var="dto">
                     <tr >
                        <td >${dto.getQna_no()} </td>
                        <td  class="array">
	                        <c:forEach begin="1" end="${dto.getQna_indent() }">&nbsp;
	                               <img src="<%=request.getContextPath() %>/images/답변아이콘.png">
	                        </c:forEach>
	                        <a href ="qna_cont.do?no=${dto.getQna_no() }&page=${page}"> ${dto.getQna_title() }</a>
	                     </td>
	                     <c:if test="${dto.getQna_modify()==1 }" >
	                      <td class="modi">수정됨</td>
	                      </c:if>
	                      <c:if test="${dto.getQna_modify()!=1}" >
	                      <td> </td>
	                      </c:if>
	                      <td> ${dto.getQna_writer()} </td>
	                      <td class="date">${dto.getQna_date()} </td>
	                  </tr>    
                 </c:forEach>
              </c:if>
              <c:if test ="${empty list }">
	              <tr>
	                   <td colspan="5" align="center">
	                      <h3>검색된 레코드가 없습니다.</h3>
	                    </td>
	               </tr>
	           </c:if>    
                     
               <tr >
                   <td colspan="5" class="array2">
                         <input type="button" class="btn btn-defult"  value="문의하기"  onclick="location.href='qna_write.do'" />
                   </td>
               </tr>        

       </table>
   </div>
   
   
   <!-- 페이지 처리 -->
   <div align="center">
   
   <ul class="pagination">
   
    <!-- 이전 페이지 처리하기 -->
            <c:if test= "${page >block }">
               <li class="paginate_button previous">
                  <a href="qna_list.do?page=1">◀◀</a> </li>
               <li> <a href="qna_list.do?page=${Block-1 }">◀</a></li>  
           </c:if>
           
           <!-- 현재페이지를 블럭에 표시 해 주기 -->
           <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
                 <c:if test="${i==page}" >
                      <li class="active"> <a href="qna_list.do?page=${i }">${i }</a> </li>    
                  </c:if>
                  
            <!-- 현재 페이지가 아닌 다른 블록들을 보여주기 위한 기능. -->          
            <c:if test="${i != page }">
                <li> <a href="qna_list.do?page=${i }">${i }</a></li>
           </c:if>
           </c:forEach>
           
           <!-- 다음 페이지로 이동 -->
           <c:if test = "${endBlock < allPage }">
              <li><a href="qna_list.do?page=${endBlock + 1 }">▶</a></li>
              <li class="paginate_button next">
                 <a href="qna_list.do?page=${allPage}">▶▶</a></li>
             </c:if>    
           </ul>
           </div>
           <br/>
           

           <!-- 검색기능 -->   
           <div class="col-xs-2 col-sm-2 col-md-1"></div>
           <div align="left" >
           <form method="post" action="<%=request.getContextPath() %>/qna_search.do">
                  <input type="hidden"  name="page" value="${page }"  />
                  <select name="find_field" style=height:26px;>
                          <option value="title">글제목</option>
                          <option value="cont">글내용</option>
                          <option value="title_cont">제목+내용</option>
                          <option value="writer">작성자</option>
                  </select>
                  <input type="text" name="find_name" />
                  <input type="submit"  class="btn btn-defult" name="검색" value="검색"/>
           </form>
          </div>
</body>
</html>