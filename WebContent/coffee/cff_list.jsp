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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.space4 {
	margin-left: auto;
	margin-right: auto;
	/* margin-left: 400px; */
}

.space5 {
	margin-top: 70px;
	text-align: center;
}

.space6 {
	margin-right: 10px;
	float: left;
}

.space7 {
	text-align: center;
	margin-top: -90px;
	margin-left: 55%;
}

.space8 {
	text-align: center;
}

.clear {
	clear: both;
}
</style>
</head>
<body>

	<div class="container" style="margin-top: 2%">
		<table class="space4">
			<c:set var="list" value="${List }" />
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
 
					<tr class="space6">
						<td><a
							href="cff_cont.do?no=${dto.getCff_no() }&page=${page }">
								<hr style="border: solid;" /> <img
								src="images/${dto.getCff_file() }">
						</a>

							<p
								style="font-size: 15px; font-family: '굴림'; margin-top: 1px; margin-bottom: 100px; font-weight: bold;" />
							<img src="images/원두그림1.png">${dto.getCff_title() }</td>
					</tr>

				</c:forEach>
			</c:if>
			<c:if test="${empty list }">
				<tr>
					<td colspan="4">
						<h3>검색된 레코드가 없습니다.</h3>
					</td>
				</tr>

			</c:if>


		</table>
	</div>

	<c:if test="${ mnum <= 100 }">
		<div class="clear"></div>
		<div class="space7">
			<br /> <input type="button" value="글쓰기" class="btn btn-defult "
				onclick="location.href='<%=request.getContextPath() %>/cff_write.do?page=${page }'">
		</div>
	</c:if>


	<div class="space5">

		<br />
		<ul class="pagination">
			<c:if test="${page > block }">
				<li class="paginate_button previous"><a
					href="cff_list.do?page=1">◀◀</a></li>
				<li><a href="cff_list.do?page=${startBlock - 1 }">◀</a></li>

			</c:if>

			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">

				<c:if test="${i == page }">
					<li class="active"><a href="cff_list.do?page=${i }">${i }</a></li>

				</c:if>

				<c:if test="${i != page }">
					<li><a href="cff_list.do?page=${i }">${i }</a></li>

				</c:if>


			</c:forEach>

			<c:if test="${endBlock < allPage }">
				<li><a href="cff_list.do?page=${endBlock + 1 }">▶</a></li>
				<li class="paginate_button next"><a
					href="cff_list.do?page=${allPage }">▶▶</a></li>

			</c:if>
		</ul>
	</div>


	<div class="space8">
		<hr width="70%">
		<br />
		<form method="post"
			action="<%=request.getContextPath()%>/cff_search.do">
			<%-- <input type="hidden" name="page" value="${page }" /> --%>
			<select name="find_field">
				<option value="title">글제목</option>
				<option value="cont">글내용</option>
				<option value="title_cont">글제목+글내용</option>
			</select> <input type="text" name="find_name"> <input type="submit"
				class="btn btn-defult " value="검색">
		</form>

	</div>

</body>
</html>