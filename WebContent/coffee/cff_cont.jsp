<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-3.4.1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>






<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
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
	/* margin-left: 5px; */
	margin-left: auto;
	margin-right: auto;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#cff_del").click(function() {
			var no = $("#no").val();
			jConfirm("삭제하시겠습니까?", "삭제확인", function(result) {
				if (result) {
					$.ajax({
						type : "post",
						url : "cff_delete.do",
						data : {
							"no" : no
						},
						datatype : "jsp",
						success : function(data) {
							if (data == 1) {
								jAlert("삭제완료", "성공", function() {
									location.href = "cff_list.do";
								});
							} else { 
								jAlert("삭제실패", "실패");
								hitory.back();
							}
						},
						error : function() {
							alert("data error");
						}
					});
				} else {
					return;
				}
			});
		});
	});
</script>

</head>
<body style="width: 95%">

	<div class="container" style="margin-top: 2%">
		<c:set var="dto" value="${cont }" />
		<input type="hidden" id="no" value="${dto.getCff_no() }">
		<table style="margin-left: auto; margin-right: auto;">
			<c:set var="dto" value="${cont }" />
			<c:if test="${!empty dto }">
				<tr>
					<td class="space1">${dto.getCff_title() }</td>
				</tr>
			</c:if>
		</table>
		<hr>
		<table style="margin-left: auto; margin-right: auto;">
			<c:set var="dto" value="${cont }" />
			<c:if test="${!empty dto }">
				<tr>
					<td><img src="images/${dto.getCff_file() }"></td>
					<td class="space2">${dto.getCff_cont1() }<br />
					<br /> ${dto.getCff_cont2() }
					</td>
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
				<td><c:if test="${ mnum <= 100 }">
						<input type="button" value="수정" class="btn btn-defult "
							onclick="location.href='cff_update.do?no=${dto.getCff_no() }&page=${page }'">
						<input type="button" value="삭제" class="btn btn-defult " id="cff_del" />
					</c:if> <input type="button" value="목록" class="btn btn-defult "
					onclick="location.href='cff_list.do?page=${page }'"></td>
			</tr>
		</table>
	</div>


</body>
</html>