<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-3.4.1.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	
	.space4 {
		/* margin-left: 400px; */
		margin-left: auto;
		margin-right: auto;
	}
	
	.space5 {
	 	margin-top:70px; 
		text-align: center;
	}
	
	.space6 {
		
		margin-right:10px;
		float: left;
			
	}
		
	.clear {
		clear: both;
	}

</style>
</head>
<body>

	<div class="container" style="margin-top: 4%"> 
		<table class="space4">				 
			 <c:set var="list" value="${searchList }" />
			 <c:if test="${!empty list }">
			 	<c:forEach items="${list }" var="dto" >
			 		
			 		<tr class="space6">		 			
			 			<td ><a href="cff_search_cont.do?no=${dto.getCff_no() }&page=${page }&find_field=${find_field }&find_name=${find_name }">
			 			<hr style="border: solid;">
			 					<img src="images/${dto.getCff_file() }"></a>
			
			 			<p style="font-size:15px; font-family:'굴림'; margin-top:1px; margin-bottom:100px; font-weight: bold;" />
			 						<img src="images/원두그림1.png">${dto.getCff_title() }</td>
			 		</tr>
	
			 	</c:forEach>
			 	</c:if> 	
			 	<c:if test="${empty list }">
				<tr>
					<td colspan="2" align="center">
						<h3>검색된 레코드가 없습니다.</h3>
					
					</td>
				</tr>
			
			</c:if>
	
			 
	 	
	     </table>
     </div>
     <div class="clear"></div>
     
	<div class="space5">
			<ul class="pagination">              <!-- ul태그는 순서없는 목록임. -->
				<c:if test="${page > block }">    <!-- -> 이전페이지 -->
					<li class="paginate_button previous">
						<a href="cff_search.do?page=1&find_field=${find_field }&find_name=${find_name }">◀◀</a></li>    <!-- -> 맨앞페이지로 가라 -->
					<li> <a href="cff_search.do?page=${startBlock - 1 }&find_field=${find_field }&find_name=${find_name }">◀</a> </li>
				
				</c:if>
				
				<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
					
					<c:if test="${i == page }">
					<li class="active"> <a href="cff_search.do?page=${i }&find_field=${find_field }&find_name=${find_name }">${i }</a></li>
					
					</c:if>
					
					<c:if test="${i != page }">
					<li> <a href="cff_search.do?page=${i }&find_field=${find_field }&find_name=${find_name }">${i }</a></li>
					
					</c:if>
					
				
				</c:forEach>
				
				<c:if test="${endBlock < allPage }">    
				    <li> <a href="cff_search.do?page=${endBlock + 1 }&find_field=${find_field }&find_name=${find_name }">▶</a> </li>   
					<li class="paginate_button next">
						<a href="cff_search.do?page=${allPage }&find_field=${find_field }&find_name=${find_name }">▶▶</a>  </li>  
									
				</c:if>			
			</ul>		
		</div>	
		<div align="center" >
			<hr width="70%" /> <br/>
			<input type="button" value="전체 목록" class="btn btn-defult "
					onclick="location.href='<%=request.getContextPath()%>/cff_list.do'">		
		</div>

</body>
</html>