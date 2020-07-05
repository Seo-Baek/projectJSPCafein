<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-3.4.1.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript">
	$(function() {
		$("#cff_update").click(function() {
			jConfirm("수정하시겠습니까?", "수정확인", function(result) {
				if (result) {
					$("form").ajaxForm({
						url : "cff_update_ok.do",
						enctype : "multipart/form-data",
						success : function(result) {
							console.log(result);
							if (result > 0) {
								jAlert("수정완료", "성공", function() {
									location.href = "cff_list.do";
								});
							} else {
								jAlert("수정실패", "실패");
								hitory.back();
							}
						},
						error : function() {
							alert("data error");
						}
					});$("form").submit();
				} else {
					return;
				}
			});
		});
	});
</script>

<style type="text/css">
	.space1 {
		margin-left: auto;
		margin-right: auto;
	}
	
	.space2 {
		margin-left: auto;
		margin-right: auto;
	}

</style>
</head>
<body>

<!-- 	<div style="text-align: center;">
		<hr width="50%" color="tomato">
			<h3>BOARD1 테이블 게시물 수정 폼</h3>
		<hr width="50%" color="tomato">
	</div> -->
		
	<div class="container" style="margin-top: 4%">
		<form method="post" 
		       enctype="multipart/form-data">
		
		<c:set var="dto" value="${edit }" />
		<input type="hidden" name="cff_no" value="${dto.getCff_no() }">
		<input type="hidden" name="page" value="${page }">
		<input type="hidden" name="old_file" value="${dto.getCff_file() }" >
		
		<table class="space1">
			
			<c:if test="${!empty dto }">
				<tr>
					<th>사진파일</th>
					<td><img src="images/${dto.getCff_file() }"></td>
					
				</tr>
				<tr>
					<th> <br />수정할 사진파일</th>
					<td> <br /><input type="file" name="title1"
								 /></td>
				 </tr>
				<tr>
					<th> <br />글제목</th>
					<td> <br /><img src="images/원두그림1.png">
						<input type="text" name="title2"
								value="${dto.getCff_title() }" /></td>
				</tr>
				<tr>
					<th> <br />정의</th>
					<td>
						 <br /><textarea rows="10" cols="60" name="content1">${dto.getCff_cont1() }</textarea> 
					</td>
				</tr>
				<tr>
					<th>부연설명</th>
					<td>
						<textarea rows="10" cols="60" name="content2">${dto.getCff_cont2() }</textarea> 
					</td>
				</tr>

			</c:if>
		</table>
		<hr width="70%">
		<table class="space2">
			<tr>
				<td colspan="2" >
					<input type="button" value="수정" class="btn btn-defult " id="cff_update" />&nbsp;&nbsp;
					<input type="reset" value="취소" class="btn btn-defult "
							onclick="location.href='cff_list.do?page=${page }'">
				</td>
			</tr>
			
		</table>
		<br /><br />
		</form>
		</div>


</body>
</html>