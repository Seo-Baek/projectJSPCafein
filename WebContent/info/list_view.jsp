<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./css/bootstrap_3.3.2.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<script src="<%=request.getContextPath()%>/js/info.js"></script>

</head>
<body>

	<div class="col-xs-12 col-sm-12 col-md-12 " style="width: 90%; margin-left: 5%; margin-top: 2%; margin-bottom: 2%;">
		<hr width="100%" class="title" />
		<h2>${fn:toUpperCase(genre)}</h2>
		<hr width="100%" class="title" />
	</div>
	<c:if test="${ mnum <= 100 }">
		<div class="col-xs-11 col-sm-11 col-md-11">
			<div class="col-xs-2 col-md-3 col-md-offset-9 col-xs-offset-10"
				style="margin-top: 2%; margin-bottom: 2%;">
				<input type="button" value="글쓰기" onclick="genre_check()"
					class="btn btn-defult center-block" />
			</div>
		</div>
	</c:if>
	<div class="container">
		<div class="row" style="width: 90%; margin-left: 5%;">
			<table class="col-md-10 col-lg-10 table table-hover table-line"
				style="margin-top: 2%; margin-bottom: 2%;">
				<thead>
					<tr>
						<th class="text-center">제목</th>
						<th class="text-center">조회수</th>
						<th class="text-center">작성일</th>
					</tr>
				</thead>
				<c:set var="list" value="${list}" />
				<c:if test="${!empty list}">
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><a
								href="info_cont.do?no=${dto.getInfo_no()}&page=${page}&genre=${dto.getInfo_genre()}">
									${dto.getInfo_title() } </a></td>
							<td>${dto.getInfo_hit() }</td>
							<td>${dto.getInfo_date().substring(0,10)  }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty list}">
					<tr>
						<td colspan="3">
							<h3>검색된 레코드가 없습니다.</h3>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
		<c:if test="${page != 0}">
			<div class="col-md-12 col-lg-12"
				style="background-color: #FCFCFC; margin-bottom: 2%; border-radius: 3%;">
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${page > block }">
							<li class="paginate_button previous"><a
								href="info_list.do?page=1&genre=${genre}">◀◀</a></li>
							<li><a
								href="info_list.do?page=${startBlock - 1 }&genre=${genre}">◀</a></li>
						</c:if>
						<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
							<c:if test="${i == page }">
								<li class="active"><a
									href="info_list.do?page=${i }&genre=${genre}">${i }</a></li>
							</c:if>
							<c:if test="${i != page }">
								<li><a href="info_list.do?page=${i }&genre=${genre}">${i }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${endBlock < allPage }">
							<li class="paginate_button previous"><a
								href="info_list.do?page=${endBlock + 1 }&genre=${genre}">▶</a></li>
							<li><a href="info_list.do?page=${allPage }&genre=${genre}">▶▶</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</c:if>
	</div>

</body>
</html>