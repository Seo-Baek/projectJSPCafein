<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./css/bootstrap_3.3.2.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/info.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />

</head>
<body>

	<div class="container">
		<div align="center">
			<div class="clear"></div>
			<c:set var="genre" value="${genre}" />
			<c:set var="dto" value="${contDTO}" />
			<c:set var="info_no" value="${dto.getInfo_no()}" />
			<input type="hidden" name="no" value="${info_no}"> <input
				type="hidden" name="genre" value="${genre}">

			<c:if test="${!empty dto}">

				<div class="col-xs-12 col-sm-12 col-md-12 ">
					<hr width="100%" class="title" />
					<h2>${dto.getInfo_title() }</h2>
					<hr width="100%" class="title" />
				</div>

				<c:if test="${genre eq 'beans' }">
					<div class="row" align="center">
						<table style="margin-top: 2%; width: 70%; margin-left: 15%"
							id="contbeans"
							class="col-xs-5 col-md-5 col-lg-5 table table-line table-condensed ">
							<thead>
								<tr class="active">
									<th class="text-center">향</th>
									<th class="text-center">산도</th>
									<th class="text-center">단맛</th>
									<th class="text-center">쓴맛</th>
									<th class="text-center">바디</th>
								</tr>
							</thead>
							<tr>
								<td>${dto.getBeans_aroma() }</td>
								<td>${dto.getBeans_acidity() }</td>
								<td>${dto.getBeans_sweet() }</td>
								<td>${dto.getBeans_bitter() }</td>
								<td>${dto.getBeans_body() }</td>
							</tr>
						</table>
					</div>
				</c:if>

				<table class="col-md-8 col-lg-8 table table-line"
					style="margin-top: 3%; margin-bottom: 4%;">
					<c:if test="${genre eq 'beans' }">
						<tr>
							<td >생산국가 : ${dto.getBeans_coun() }&nbsp;<input type="button"
								class="btn btn-defult " onclick="map()" value="생산국가위치">
								<input type="hidden" id="add" value="${dto.getBeans_counadd()}">
							</td>
						</tr>
					</c:if>
					<c:if test="${genre eq 'country' }">
						<tr>
							<td>${dto.getCoun_7() }&nbsp;<input type="button"
								class="btn btn-defult " onclick="map()" value="나라위치"> <input
								type="hidden" id="add" value="${dto.getCoun_add()}">
							</td>
						</tr>
					</c:if>
					<c:if test="${genre eq 'extra' }">
						<tr>
							<td>추출분류 : ${dto.getExtra_genre() }</td>
						</tr>
					</c:if>
					<tr>
						<td>${dto.getInfo_cont() }</td>
					</tr>
					<c:if test="${!empty dto.getInfo_file() }">
						<tr>
							<td><img alt="다운로드" src="./images/download.png" width="5%">
								<a href="download.do?file=${dto.getInfo_file() }">
									${dto.getInfo_file() }</a></td>
						</tr>
					</c:if>
					<c:if test="${ mnum <= 100 }">
						<tr>
							<td align="right"><input type="button"
								value="수정" class="btn btn-defult "
								onclick="location.href='<%=request.getContextPath()%>/info_writecont.do?no=${dto.getInfo_no()}&page=${page}&genre=${genre}'" />
								&nbsp;<input type="button" value="삭제" class="btn btn-defult "
								id="delete_btn" />&nbsp;<input type="button" value="목록"
								class="btn btn-defult "
								onclick="location.href='<%=request.getContextPath()%>/info_list.do?page=${page}&genre=${genre}'" /></td>
						</tr>
					</c:if>
				</table>
			</c:if>
			<c:if test="${empty dto}">
				<div>
					<h3>검색된 레코드가 없습니다.</h3>
				</div>
			</c:if>
			<div>
				<c:if test="${!empty repList }">
					<script>
						function showForm(name) {
							var x = document.getElementById(name);
							if (x.style.display === "none") {
								x.style.display = "block";
							} else {
								x.style.display = "none";
							}
						}
					</script>
					<c:forEach var="rep" items="${repList }">
						<div style="margin-left: 5%">
							<div
								style="width: 100%; text-align: left; margin-top: 1%; margin-left: ${rep.getDep() * 50 }px;">
								<label><img
									src="<%=request.getContextPath()%>/images/답변화살표.png">${rep.getWriter() }
									: ${rep.getCont() } (${rep.getRegdate() })</label>
								<c:if test="${nickname != null}">
									<!-- 로그인 중이면 답글 달기 가능 -->
									<input type="button"
										onclick="showForm('myForm_${rep.getRep_num() }')" value="답글달기"
										class="btn btn-defult" style="width: 100px">
									<div id="myForm_${rep.getRep_num() }" style="display: None;">
										<form action="<%=request.getContextPath()%>/writeReply.do"
											method="post">
											<input type="hidden" name="genre" value="${genre}"> <input
												type="hidden" name="page" value="${page}">
											<table style='width: 60%'>
												<tr>
													<th>${nickname }</th>
													<td><textarea style="width: 100%;" name="content"
															placeholder="악플 나빠여" required="required"></textarea></td>
													<td><input type="submit" value="저장"
														class="btn btn-defult center-block" /></td>
												</tr>
											</table>
											<!-- 이 댓글이 부모 댓글이 될 것임 -->
											<input type="hidden" name="parentNum"
												value="${rep.getRep_num() }">
											<!-- 이 댓글의 깊이 (현재 댓글의 대댓글이므로 깊이 +1-->
											<input type="hidden" name="depth"
												value="${rep.getDep() + 1 }">
											<!-- 이 댓글의 게시글 번호 -->
											<input type="hidden" name="boardNum" value="${info_no}">

										</form>
									</div>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div
				style="width: 100%; text-align: left; margin-top: 2%; margin-left: 3%">
				<form action="<%=request.getContextPath()%>/writeReply.do"
					method="post">
					<input type="hidden" name="genre" value="${genre}"> <input
						type="hidden" name="page" value="${page}">
					<!-- 부모 댓글은 없음 -->
					<input type="hidden" name="parentNum" value="0">
					<!-- 이 댓글의 깊이 없음-->
					<input type="hidden" name="depth" value="0">
					<!-- 이 댓글의 게시글 번호 -->
					<input type="hidden" name="boardNum" value="${info_no}">
					<table style='width: 60%'>
						<tr>
							<th>${nickname }</th>
							<td><textarea style="width: 100%;" name="content"
									placeholder="악플 나빠여" required="required"></textarea>
							<td><input type="submit" value="저장" id="rep_submit"
								class="btn btn-defult center-block" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div align="center">
			<div class="col-md-1 "></div>
			<table class="col-md-8 col-lg-8 table table-hover table-line"
				style="margin-top: 7%; margin-bottom: 4%;">
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

			<div>
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
	</div>
</body>
</html>