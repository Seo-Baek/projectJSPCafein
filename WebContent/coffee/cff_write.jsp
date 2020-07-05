<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
th {
	background-color: #eee;
	width: 15%;
}
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-3.4.1.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript">
	$(function() {
		$("#cff_write").click(function() {
			jConfirm("업로드하시겠습니까?", "업로드확인", function(result) {
				if (result) {
					$("form").ajaxForm({
						url : "cff_write_ok.do",
						enctype : "multipart/form-data",
						success : function(result) {
							console.log(result);
							if (result > 0) {
								jAlert("업로드완료", "성공", function() {
									location.href = "cff_list.do";
								});
							} else {
								jAlert("업로드실패", "실패");
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
</head>
<body>

	<div class="container" style="margin-top: 4%">

		<!-- <hr width="50%" color="tomato">
			<h3>cff 게시판 글쓰기 폼</h3>
		<hr width="50%" color="tomato">
		<br /><br /> -->

		<form method="post">
			<div class="row">
				<div class="col-sm-2 col-md-2 col-lg-2"></div>
				<table border="2" cellspacing="0"
					class="col-xs-8 col-sm-8 col-md-6 col-lg-8 table"
					style="width: 70%">
					<tr>
						<th style="text-align: center;">사진파일</th>
						<td style="padding-left: 55px;"><input type="file"
							name="title1" /></td>
					</tr>
					<tr>
						<th style="text-align: center;">글제목</th>
						<td style="padding-left: 55px;"><img src="images/원두그림1.png">
							<input type="text" name="title2" /></td>
					</tr>
					<tr>
						<th style="text-align: center;">정의</th>
						<td align="center"><textarea rows="10" cols="80"
								name="content1" width="100%"></textarea></td>
					</tr>
					<tr>
						<th style="text-align: center;">부연설명</th>
						<td align="center"><textarea rows="10" cols="80"
								name="content2" width="100%"></textarea></td>
					</tr>
				</table>
				<br /> <br />
			</div>
			<br />
			<div class="row">
				<table class="table" style="width: 100%;">
					<tr>
						<td colspan="2" align="center"><br />
						<input type="button" value="글쓰기" class="btn btn-defult " id="cff_write" />&nbsp;&nbsp; <input
							type="reset" value="취소" class="btn btn-defult "
								onclick="location.href='cff_list.do'"/></td>
					</tr>
				</table>
			</div>

		</form>
	</div>

</body>
</html>