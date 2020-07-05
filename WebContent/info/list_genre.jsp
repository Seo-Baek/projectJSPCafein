<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
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
<script src="<%=request.getContextPath()%>/js/info.js"></script>

</head>
<body>

	<div align="center" class="col-xs-12 col-sm-12 col-md-12">
		<form action="<%=request.getContextPath()%>/info_write.do"
			method="post" name="f">
			<table class="col-md-8 col-lg-8 table table-line"
				style="margin-top: 7%; margin-bottom: 4%;">

				<tr>
					<td align="center">
						<h4>[등록할 게시글의 종류를 선택하세요]</h4>
				</tr>
				<tr>
					<td height="30" align="center"><select name="genre"
						onchange="selectnow()">
							<option value="">:::종류를 선택하세요:::</option>
							<option value="info">[정보]</option>
							<option value="beans">[원두]</option>
							<option value="country">[나라]</option>
							<option value="extra">[추출방식]</option>
					</select>
				</tr>

				<tr>
					<td align="center"><input type="button" value="선택"
						onclick="choiceOk()" class="btn btn-defult " />&nbsp; <input
						type="button" value="취소" onclick="parent.window.close();"
						class="btn btn-defult " /></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>