<%@page import="com.info.model.user.InfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운영자 정보 확인</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
 <script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
</head>
<body>

	<div class="container text-center" align="center" style="margin-top: 2%;">
		<table border="1">
			<tr>
				<td><h3>게시를 위해서 비밀번호를 입력하세요.</h3></td>
			</tr>
			<tr>
				<td>
					<label>비밀번호 : </label>
					<input type="password" id="pwd" />
					<input type="hidden" id="board_no" value="${dto.getBoard_no() }" />
					<input type="hidden" id="board_pwd" value="${dto.getBoard_pwd() }" />
				</td>
			</tr>
			<tr>
				<td><h3>재확인 : 아래의 글을 정확하게 입력해주세요.</h3></td>
			</tr>
			<tr>
				<td><label id="checkText">개나리 노란 꽃그늘 아래</label></td>
			</tr>
			<tr>
				<td><input type="text" id="inputText" /></td>
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
		console.log($("#checkText").text().trim());
		console.log($("#inputText").val().trim());
		if($("#board_pwd").val() != $("#pwd").val()){
			alert("비밀번호가 틀립니다.");
		} else if($("#checkText").text().trim() != $("#inputText").val().trim()) {
			alert("확인 글이 정확하게 입력되지 않았습니다.");
		}else{
			let board_no = $("#board_no").val();
			let ok =confirm('공지사항이 정보광장에 노출됩니다. \n게시하시겠습니까?');
			if(ok == true){
				opener.location.href="up_notice_ok.do?board_no="+board_no;
				parent.window.close(); 
			} 
			
		}
	});
	
</script>
</body>
</html>