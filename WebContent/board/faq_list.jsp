<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap_3.3.2.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script type="text/javascript">

function showDiv(trc){
	($('#'+trc).css("display") == "block") ? $('#'+trc).css("display","none") : $('#'+trc).css("display","block") ;
	
}

</script>
<style type="text/css">
.faq_wrap {
	border-top: 1px solid #222;
	border-bottom: 1px solid #222;
	/* margin : 70px 200px  50px 200px;  */
	width: 80%;
}

.faq_title {
	boarder-bottom: 1px solid #ddd;
}

.faq_wrap ul {
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	padding-inline-start: 40px;
}

.faq_wrap li {
	display: list-item;
	text-align:
}

.faq_wrap ul, li {
	list-style: none;
	vertical-align: baseline;
}

.faq_wrap dd {
	margin-inline-start: 0px;
}

.mark {
	font-weight: blod;
	color: red;
	font-size: 15px;
	background-color: #0000;
}

dt.mark {
	float: left;
}

.mark1 {
	font-weight: blod;
	color: #5D5D5D;
	font-size: 15px;
	padding: .2em;
}

dt.mark1 {
	float: left;
}

.faq_warp dd.a {
	margin-inline-start: 40px;
}

.faq_wrap dd, dt {
	padding: 2.5px 0 2.5px 0;
}

.pagination {
	height: 27px;
	margin-top: 50px;
}

h1 {
	text-align: left;
}
</style>
</head>
<body style="width: 96%;">



	<div class="row" align="center">
		<div class="col-xs-1 col-sm-1 col-md-1"></div>
		<div class="col-xs-8 col-sm-8 col-md-8" align="left"
			style="margin-bottom: 2%;">
			<h1>FAQ</h1>
		</div>
	</div>
	<!-- faq 전체부분 감싸주기 -->
	<div class="faq_wrap" style="margin: 0 10%;">

		<c:set var="list" value="${List }" />

		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="dto">


				<!-- faq 제목 부분 -->
				<dt class="faq_title" style="border-bottom: 1px solid #ddd;">
					<ul>
						<li class="li_faq">
							<dl>
								<dt class="mark">Q&nbsp;&nbsp;</dt>
								<dd class="a" onclick="showDiv(${dto.getFaq_no() })">${dto.getFaq_title() }
								</dd>
							</dl>
						</li>
					</ul>
				</dt>

				<!-- faq 내용 부분 -->
				<dd id="${dto.getFaq_no() }"
					style="display: none; background-color: #f4f4f2;">
					<ul>
						<li class="li_faq">
							<dl>
								<dt class="mark1">A&nbsp;&nbsp;</dt>
								<dd class="a">${dto.getFaq_cont() }</dd>
							</dl>
						</li>
					</ul>
				</dd>

			</c:forEach>
		</c:if>



		<c:if test="${empty list }">
			<tr>
				<td colspan="2" align="center">
					<h3>검색된 레코드가 없습니다.</h3>
				</td>
			</tr>
		</c:if>
	</div>

	<!-- 페이지 처리 -->
	<div align="center">

		<ul class="pagination">

			<!-- 이전 페이지 처리하기 -->
			<c:if test="${page >block }">
				<li class="paginate_button previous"><a
					href="faq_list.do?page=1">◀◀</a></li>
				<li><a href="faq_list.do?page=${Block-1 }">◀</a></li>
			</c:if>

			<!-- 현재페이지를 블럭에 표시 해 주기 -->
			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
				<c:if test="${i==page}">
					<li class="active"><a href="faq_list.do?page=${i }">${i }</a>
					</li>
				</c:if>

				<!-- 현재 페이지가 아닌 다른 블록들을 보여주기 위한 기능. -->
				<c:if test="${i != page }">
					<li><a href="faq_list.do?page=${i }">${i }</a></li>
				</c:if>
			</c:forEach>

			<!-- 다음 페이지로 이동 -->
			<c:if test="${endBlock < allPage }">
				<li><a href="faq_list.do?page=${endBlock + 1 }">▶</a></li>
				<li class="paginate_button next"><a
					href="faq_list.do?page=${allPage}">▶▶</a></li>
			</c:if>
		</ul>
	</div>



</body>
</html>