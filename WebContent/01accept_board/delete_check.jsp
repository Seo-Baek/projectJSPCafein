<%@page import="com.info.model.user.InfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 확인 - 비밀번호입력</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
</head>
<body>

	<div class="container text-center" align="center" style="margin-top: 2%;">
		<table border="1">
			<tr>
				<td><h3>삭제를 위해서 비밀번호를 입력하세요.</h3></td>
			</tr>
			<tr>
				<td>
					<label>비밀번호 : </label>
					<input type="password" id="pwd" />
					<input type="hidden" id="board_no" value="${dto.getBoard_no() }" />
					<input type="hidden" id="board_pwd" value="${dto.getBoard_pwd() }" />
					<c:set var="category" value="${param.category }" />
					<input type="hidden" id="category" value="${category }" />
				</td>
			</tr>
		</table>
		<input type="button" id="check" value="확인"/>
		<input type="button" id="cancle" value="돌아가기"/>
	</div>
<script type="text/javascript">
	$("#cancle").click(function(){
		let ok = confirm("취소하시겠습니까?");
		if(ok == true){
			parent.window.close();
		}
	});
	
	$("#check").click(function(){
		if($("#board_pwd").val() != $("#pwd").val()){
			alert("비밀번호가 틀립니다.");
		} else{
			let board_no = $("#board_no").val();
			let ok =confirm('정말 삭제하시겠습니까?');
			if(ok == true){
				if($("#category").val() == 'mine'){
					opener.location.href="realDelete.do?board_no="+board_no;
				} else{
					opener.location.href="delete_ok.do?board_no="+board_no;					
				}
				parent.window.close();
			} 
			
		}
	});
	
</script>
</body>
</html>