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
	.space1 {
		font-size: 50px;
		font-family: 굴림;
		font-weight: bold;
	}
	
	.space2 {
		width: 300px;
		padding-left: 10px;
	}
	
	hr {
		width: 800px;
		margin-left: auto;
		margin-right: auto;
	}
		
</style>


</head>
<body>

	<div class="container" style="margin-top: 4%">
	
		<table style="margin-left: auto; margin-right: auto;">
			<c:set var="dto" value="${searchCont }" />
			<c:if test="${!empty dto }"> 
				<tr>
					<td class="space1">${dto.getCff_title() } 
					</td>					
				</tr>
			</c:if>
		</table>
		<hr>
		<table style="margin-left: auto; margin-right: auto;">
			<c:set var="dto" value="${searchCont }" />
			<c:if test="${!empty dto }"> 					
				<tr>
					<td><img src="images/${dto.getCff_file() }" ></td>
					<td class="space2">${dto.getCff_cont1() } <br /><br />
					    ${dto.getCff_cont2() }</td>					  
				</tr>
			</c:if>
			<c:if test="${empty dto }">
            <tr>
               <td colspan="2" align="center">
                  <h3>검색된 레코드가 없습니다.</h3>
               </td>
            </tr>
         </c:if>
			


		</table>
		<hr>
			<table style="margin-left: auto; margin-right: auto;">
			<tr>
			  <td><input type="button" value="검색목록"  class="btn btn-defult "
								onclick="location.href='cff_search.do?page=${page }&find_field=${find_field }&find_name=${find_name }'">
				  <input type="button" value="전체목록" class="btn btn-defult "
								onclick="location.href='cff_list.do'">	</td>
			</tr>	
			</table>		
	</div>