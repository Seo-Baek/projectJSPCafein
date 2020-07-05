<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/bootstrap-3.4.1.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js">
	/* Bootstrap CDN JavaScript */
</script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript">
	$(function() {
		$('.btn_submit').click(function() {

			$("form").ajaxForm({
				type : "post",
				url : "taste.do",
				success : function(data) {
					console.log(data);
					if (data == 1) { // 존재하는 경우
						jAlert("제출 성공!", "SUCCESS", function() {
							location.href = "taste_list.do"
						});
					} else {
						jAlert("제출 실패", "ERROR");
					}
				},
				error : function() { // 데이터 통신이 실패한 경우
					alert("data error");
				}
			});
			$("form").submit();

		});

	});
</script>
<style type="text/css">
	
	
	
</style>
</head>
<body>
	<section id="content">
		<div class="container">
		<div class="col-xs-10 col-sm-10 col-md-10 " style="margin-left: 15%;">
			<hr width="100%" class="title" />
			<h2 style="font-weight: bold;">원두 취향 테스트</h2>
			<hr width="100%" class="title" />
			<div align="center">
				<input type="button" value="결과목록" class="btn btn-defult "
					onclick="location.href = '<%=request.getContextPath()%>/taste_list.do'">
			</div>

		</div>
		<form method="post">

			<div class="col-xs-12 col-sm-12 col-md-12 " align="center">
				<c:set var="list" value="${list}" />
				<c:if test="${!empty list}">
					<input type="hidden" name="count" value="${count }">
					<c:forEach items="${list }" var="dto">
						<table class="col-xs-5 col-md-5 col-lg-5 table table-line text-center write"
							style="margin-left: 20%; margin-top: 2%; margin-bottom: 2%; width: 60%">
							<tr>
								<td><h4>${dto.getQue_title() }</h4></td>
							</tr>
							<tr>
								<td><div align="center" class="btn-group"
										data-toggle="buttons">
										<label class="btn btn-primary "> <input type="radio"
											value="1" name="que[${dto.getQue_no() }]" autocomplete="off"
											checked>맞아!
										</label> <label class="btn btn-warning "> <input type="radio"
											value="0" name="que[${dto.getQue_no() }]" autocomplete="off">모르겠어ㅠㅠ
										</label> <label class="btn btn-danger "> <input type="radio"
											value="-1" name="que[${dto.getQue_no() }]" autocomplete="off">아니야!
										</label>
									</div></td>
							</tr>
						</table>
					</c:forEach>
				</c:if>
				<c:if test="${empty list}">

					<h3>검색된 레코드가 없습니다.</h3>

				</c:if>
				<c:if test="${!empty list}">
				</c:if>

			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 " align="center">
				<input type="button" value="제출" class="btn btn-defult btn_submit">
				&nbsp; <input type="reset" value="다시하기" class="btn btn-defult" />
			</div>

		</form>
		</div>
	</section>
</body>
</html>