<%@ page import="com.info.model.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap-3.4.1.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript">
	function admin() {
		document.getElementById("admin").style.display = "block";
		document.getElementById("user").style.display = "none";
		document.getElementById("out").style.display = "none";
	}

	function user() {
		document.getElementById("admin").style.display = "none";
		document.getElementById("user").style.display = "block";
		document.getElementById("out").style.display = "none";
	}

	function out() {
		document.getElementById("admin").style.display = "none";
		document.getElementById("user").style.display = "none";
		document.getElementById("out").style.display = "block";
	}
</script>
<style type="text/css">
th, td {
	text-align: center;
}
</style>

</head>
<body>
	<div class="container">
		<div class="col-xs-12 col-sm-12 col-md-12 "
			style="margin-left: 10%; margin-top: 2%; margin-bottom: 2%; width: 80%">
			<hr width="100%" class="title" />
			<h2>ADMIN PAGE</h2>
			<hr width="100%" class="title" />
		</div>

		<div class="col-xs-12 col-sm-12 col-md-12" align="center">

			<div align="left" class="btn-group" data-toggle="buttons">
				<label class="btn btn-primary " onclick="admin()"> <input
					type="radio" name="options" autocomplete="off" checked>관리자
				</label> <label class="btn btn-danger " onclick="user()"> <input
					type="radio" name="options" autocomplete="off">일반회원
				</label> <label class="btn btn-warning " onclick="out()"> <input
					type="radio" name="options" autocomplete="off">탈퇴회원
				</label>
			</div>
			<!-- 버튼 끝 -->

			<div id="admin" style="display: none;">
				<table class="col-xs-5 col-md-5 col-lg-5 table table-line write"
					style="margin-left: 10%; margin-top: 2%; margin-bottom: 2%; width: 80%">
					<tr>
						<th>관리자 No.</th>
						<th>관리자 ID</th>
						<th>관리자 닉네임</th>
						<th>가입 일시</th>
						<th>탈퇴</th>
					</tr>

					<c:set var="list" value="${List }" />
					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="dto">
							<c:if test="${dto.getM_no() <= 100 && 0 < dto.getM_no()}">
								<tr>
									<td>${dto.getM_no() }</td>
									<td>${dto.getM_id() }</td>
									<td>${dto.getM_nickname() }</td>
									<td>${dto.getM_date() }</td>
									<c:if test="${sessionScope.mno == dto.getM_no() }">
										<td><input type="button" value="로그아웃" id="logout_btn"
											class="btn btn-defult " /></td>
									</c:if>
									<c:if test="${sessionScope.mno != dto.getM_no() }">
										<td><a href="mypage.do?mno=${dto.getM_no() }">수정/탈퇴</a></td>
									</c:if>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="5"><h3>검색된 레코드가 없습니다.</h3></td>
						</tr>
					</c:if>
				</table>
			</div>
			<!-- admin 끝 -->


			<div id="user" style="display: block;">
				<table class="col-xs-5 col-md-5 col-lg-5 table table-line write"
					style="margin-left: 10%; margin-top: 2%; margin-bottom: 2%; width: 80%">

					<tr>
						<th>회원 No.</th>
						<th>회원 ID</th>
						<th>회원 닉네임</th>
						<th>가입 일시</th>
						<th>회원 관리</th>
					</tr>

					<c:if test="${!empty list }">
						<c:forEach items="${list }" var="dto">
							<c:if test="${dto.getM_no() > 100 }">
								<tr>
									<td>${dto.getM_no() }</td>
									<td>${dto.getM_id() }</td>
									<td>${dto.getM_nickname() }</td>
									<td>${dto.getM_date() }</td>
									<td><a href="mypage.do?mno=${dto.getM_no() }">수정/탈퇴</a></td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr>
							<td colspan="5"><h3>검색된 레코드가 없습니다.</h3></td>
						</tr>
					</c:if>

				</table>
			</div>
			<!-- user 끝 -->

			<div id="out" style="display: none;">
				<table class="col-xs-5 col-md-5 col-lg-5 table table-line write"
					style="margin-left: 10%; margin-top: 2%; margin-bottom: 2%; width: 80%">

					<tr>
						<th>회원 No.</th>
						<th>회원 ID</th>
						<th>회원 닉네임</th>
						<th>탈퇴 일시</th>
					</tr>

					<c:if test="${!empty outList }">
						<c:forEach items="${outList }" var="dto">
							<tr>
								<td>${dto.getM_no() }</td>
								<td>${dto.getM_id() }</td>
								<td>${dto.getM_nickname() }</td>
								<td>${dto.getM_date() }</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty outList }">
						<tr>
							<td colspan="4"><h3>검색된 레코드가 없습니다.</h3></td>
						</tr>
					</c:if>
				</table>
			</div>
			<!-- 탈퇴회원 끝 -->
		</div>
		<!-- center 끝 -->
	</div>

	<script type="text/javascript">
		$("#logout_btn").click(function() {
			$.ajax({
				type : "post", // 데이터 전송 방식(Get, Post 방식)
				url : "logout.do", // 파일 주소와 경로
				// 통신이 성공한 경우 결과 값을 data라는 변수에 저장
				success : function(data) {
					if (data) { // 존재하는 경우
						jAlert(data, "SUCCESS", function() {
							window.top.location.href = "index.jsp";
						});
					}
				},
				error : function() { // 데이터 통신이 실패한 경우
					alert("data error");
				}
			}); // Ajax end
		});
	</script>
</body>
</html>

