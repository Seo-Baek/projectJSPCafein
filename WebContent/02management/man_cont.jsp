<%@page import="com.info.model.user.InfoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<link rel="stylesheet" href="css/bootstrap-3.4.1.css">
<script src="https://kit.fontawesome.com/74c225bc71.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<style type="text/css">
a {
	color: #787878;
	text-shadow: 3px 3px 3px #gray;
	font-weight: bold;
	font-size: 16px;
}

pre {
	white-space: -moz-pre-wrap; /* Mozilla, supported since 1999 */
	white-space: -pre-wrap; /* Opera */
	white-space: -o-pre-wrap; /* Opera */
	white-space: pre-wrap;
	/* CSS3 - Text module (Candidate Recommendation) http://www.w3.org/TR/css3-text/#white-space */
	word-wrap: break-word; /* IE 5.5+ */
}

table {
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	width: 90%;
}

#cont {
	border-right: 1px solid gray;
	border-left: 1px solid gray;
	background-color: lightgray;
}

#title {
	font-size: 18px;
	color: balck;
	font-weight: bold;
}

#info {
	font-size: 13px;
	color: gray;
}

#date {
	font-size: 13px;
	color: gray;
}

#ownComm {
	height: 80pt;
	width: 60%;
	padding-bottom: 4%;
	font-size: 50%;
}

pre {
	background-color: lightgray;
	border: none;
}

.preNext {
	cursor: pointer;
	height: 30pt;
	border-bottom: 1px dotted lightgray;
}

.contbutton {
	background-color: #eee;
}

.contbutton:hover {
	background-color: #DEDEDE;
	border-color: #b4b4b4;
}

ul {
	list-style: none;
}

li {
	float: left;
}

.comment {
	background-color: #eee;
}

.reply {
	padding-left: 8%;
	padding-right: 8%;
	padding-bottom: 2%;
}

.block {
	cursor: default;
	background-color: #eee;
	border: 0.5px solid #b4b4b4;
}

.block:hover {
	cursor: default;
	background-color: #eee;
	border: 0.5px solid #b4b4b4;
}
</style>
</head>
<body>

	<c:set var="dto" value="${Cont }" />
	<div class="container" align="center" style="margin-right: %15;">
		<br />
		<br />
		<br />
		<div align="right" style="padding-right: 3%;">
			<input class="btn contbutton" type="button" value="목록"
				onclick="location.href='enter_list.do?mno=${sessinScope.mno}&accept=1'" />
		</div>
		<br />
		<div>
			<table cellspacing="0" id="cont">
				<tr>
					<td style="padding-top: 2%;"><input type="hidden" id="mno"
						name="mno" value="${dto.getBoard_mno() }" />
						<div class="col-xs-1" style="margin-left: -8%;"></div>
						<div class="col-xs-8">
							<h3>${dto.getBoard_title() }<small>|${cat } </small>
							</h3>
						</div></td>
				</tr>
				<tr>
					<td>
						<hr style="border-top: 1px solid gray; border-bottom: none" />
						<div class="col-xs-9 " align="left">
							<pre>
								<label style="font-size: 14px; color: gray;"><i
									class="fab fa-gratipay" style="color: hotpink;"></i> ${dto.getBoard_writer() }</label>
							</pre>
						</div>
						<div class="col-xs-2" style="margin-left: 5%;" align="right">
							<span id="date" style="font-size: 14px;">${dto.getBoard_date()}</span>
						</div>
					</td>
				</tr>
				<tr>
					<td><br />
						<div class="col-xs-9 col-md-10 col-xs-offset-1 col-md-offset-1"
							style="margin-bottom: 2%;" align="center">
							<pre style="height: auto; width: auto; font-size: 17px;">${dto.getBoard_cont() }</pre>
						</div></td>
				</tr>
				<tr>
					<td align="center"><br />
					<br /></td>
				</tr>
				<tr>
					<td align="right">
						<div
							style="margin-right: 3%; padding-bottom: 2%; padding-top: 2%;">
							<a
								href="https://creativecommons.org/licenses/by-nc-nd/4.0/deed.ko"
								target="_blank"> <i class="fab fa-creative-commons-by">저작자표시</i>
								<i class="fab fa-creative-commons-nc">비영리</i> <i
								class="fab fa-creative-commons-nd">변경금지</i>
							</a>
						</div>
					</td>
				</tr>
				<tr>
					<td><hr width="100%" /></td>
				</tr>
			</table>
			<form method="post" action="man_allow.do">
				<input type="hidden" id="title" name="title"
					value="${dto.getBoard_title() }" /> <input type="hidden"
					id="board_no" name="board_no" value="${dto.getBoard_no() }" />
				<textarea class="hide" id="cont" name="cont">${dto.getBoard_cont() }</textarea>

				<div class="row" style="margin-bottom: 3%;">
					<div class="col-sm-7 col-sm-offset-2" align="center">
						<input class="btn contbutton update" type="button" value="수정"
							style="margin-top: 1.9%; margin-left: 7.5%;" /> <input
							type="button" class="btn contbutton allow" value="허가"
							style="margin-top: 1.9%; margin-left: 7.5%;" />
					</div>
				</div>
			</form>
		</div>

		<script type="text/javascript">
			$(".update").click(function() {
				let board_no = $("#board_no").val();
				location.href = "man_update.do?board_no=" + board_no;
			});

			$(".allow").click(
					function() {
						jConfirm('대기글을 허가하시겠습니까?', '허가확인', function(result) {
							if (result) {
								let replacing = $("#title").val().replace(
										/확인완료★/g, '').replace(/재작성★/g, '')
										.trim();
								$("#title").val(replacing);
								$("form").submit();
							}
						});

					});

			/* $(".block").click(function(){
				let check = confirm('로그인하시겠습니까?');
				if(check == true)
					window.open('login.jsp');
			}); */
		</script>
</body>
</html>