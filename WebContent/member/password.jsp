<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap-3.4.1.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="<%=request.getContextPath()%>/js/login.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

</head>
<body>

	<div align="center" class="col-xs-12 col-sm-12 col-md-12">
		<form method="post">
			<table class="col-md-8 col-lg-8 table table-line"
				style="margin-top: 7%; margin-bottom: 4%;">

				<tr>
					<td colspan="2" align="center">
						<h4>[아이디와 이메일을 입력하세요]</h4>
				</tr>
				<tr>
					<th>ID</th>
					<td><input type="text" id="m_id" name="m_id"
						placeholder="아이디를 입력하세요." class="required"></td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td><input type="text" name="m_email1" class="required"
						placeholder="이메일 아이디"> @ <select name="m_email2"
						class="required">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="nate.com">nate.com</option>
					</select></td>
				</tr>

				<tr>
					<td align="center" colspan="2">
						<%-- 경고문이 출력되는 위치 --%> <span id="nullcheck"></span> <br /> <input
						type="button" value="확인" id="checkUser" class="btn btn-defult " />&nbsp;
						<input type="button" value="취소" onclick="parent.window.close();"
						class="btn btn-defult " />
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>