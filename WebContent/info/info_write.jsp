<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./css/bootstrap-3.4.1.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous">
	/* jQuery CDN */
</script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<!-- include summernote css/js -->
<!-- summernote 스타일 관련 cdn-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.css"
	rel="stylesheet">
<!-- summernote 자바스크립트 cdn-->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.js"></script>
</head>
<!-- summernote 한글 관련 cdn-->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/lang/summernote-ko-KR.min.js"></script>
<script src="<%=request.getContextPath()%>/js/write.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />

</head>
<body>

	<div align="center" class="col-xs-11 col-sm-11 col-md-11">
		<form action="<%=request.getContextPath()%>/info_commit.do"
			name="form" method="post" enctype="multipart/form-data">
			<%-- enctype : 이진 파일 업로드를 위한 속성 --%>
			<c:set var="dto" value="${contDTO }" />
			<c:if test="${!empty dto }">
				<input type="hidden" name="no" value="${no}">
				<input type="hidden" name="page" value="${page}">
			</c:if>

			<table class="col-md-8 col-lg-8 table table-line write"
				style="margin-top: 7%; margin-bottom: 4%;">
				<c:set var="genre" value="${genre}" />
				<c:set var="coun" value="${country }" />
				<tr>
					<th>게시글 종류</th>
					<td><input type="text" name="genre" value="${genre}" readonly /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"
						value="${dto.getInfo_title() }" class="required" /></td>
				</tr>
				<%-- 원두 게시글 등록 --%>
				<c:if test="${genre eq 'beans' }">
					<tr>
						<th>나라 선택</th>
						<td><select name="coun_no" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getCoun_no() }">${dto.getBeans_coun() }</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::나라를 선택하세요:::</option>
								</c:if>
								<c:forEach items="${coun }" var="coun">
									<option value="${coun.key }">${coun.value }</option>
								</c:forEach>
						</select> &nbsp; <input type="button" value="나라등록" class="btn btn-defult "
							onclick="location.href='<%=request.getContextPath()%>/info_write.do?genre=country'" />
						</td>
					</tr>
					<tr>
						<th>평가 항목</th>
						<td><select name="beans_aroma" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getBeans_aroma() }">${dto.getBeans_aroma() }점</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::향(5점만점):::</option>
								</c:if>
								<c:forEach var="i" begin="1" end="5">
									<option value="${i }">${i }점</option>
								</c:forEach>
						</select>&nbsp; <select name="beans_acidity" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getBeans_acidity() }">${dto.getBeans_acidity() }점</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::산도(5점만점):::</option>
								</c:if>
								<c:forEach var="i" begin="1" end="5">
									<option value="${i }">${i }점</option>
								</c:forEach>
						</select>&nbsp; <select name="beans_sweet" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getBeans_sweet() }">${dto.getBeans_sweet() }점</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::단맛(5점만점):::</option>
								</c:if>
								<c:forEach var="i" begin="1" end="5">
									<option value="${i }">${i }점</option>
								</c:forEach>
						</select>&nbsp; <select name="beans_bitter" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getBeans_bitter() }">${dto.getBeans_bitter() }점</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::쓴맛(5점만점):::</option>
								</c:if>
								<c:forEach var="i" begin="1" end="5">
									<option value="${i }">${i }점</option>
								</c:forEach>
						</select>&nbsp; <select name="beans_body" class="required">
								<c:if test="${!empty dto }">
									<option value="${dto.getBeans_body() }">${dto.getBeans_body() }점</option>
								</c:if>
								<c:if test="${empty dto }">
									<option value="">:::바디(5점만점):::</option>
								</c:if>
								<c:forEach var="i" begin="1" end="5">
									<option value="${i }">${i }점</option>
								</c:forEach>
						</select></td>
					</tr>
				</c:if>
				<%-- 나라 게시글 등록 --%>
				<c:if test="${genre eq 'country' }">
					<tr>
						<th>대륙 선택</th>
						<td><select name="coun_val" class="required">
								<c:if test="${!empty dto }">
									<fmt:parseNumber var="num" value="${dto.getCoun_no()/100 }"
										integerOnly="true" />
									<option value="${num }|${dto.getCoun_7() }">${dto.getCoun_7() }</option>
								</c:if>
								<option value="">:::대륙을 선택하세요:::</option>
								<option value="1|아시아">아시아</option>
								<option value="2|남아메리카">남아메리카</option>
								<option value="3|아프리카">아프리카</option>
								<option value="4|북아메리카">북아메리카</option>
								<option value="5|유럽">유럽</option>
								<option value="6|오스트레일리아">오스트레일리아</option>
								<option value="7|남극">남극</option>
						</select></td>
					</tr>
					<c:if test="${empty dto }">
						<tr>
							<th>나라 검색</th>
							<td><input type="text" name="coun_name" id="coun_name"
								class="required" /> &nbsp; <input type="button" value="중복체크"
								class="btn btn-defult " id="check_btn" /> <br /> <%-- 경고문이 출력되는 위치 --%>
								<span id="check"></span></td>
						</tr>
					</c:if>
					<tr>
						<th>주소</th>
						<td><c:if test="${!empty dto }">
								<input type="hidden" name="conu_no" value="${dto.getCoun_no()}">
							</c:if><input type="text" name="coun_add" value="${dto.getCoun_add() }" /></td>
					</tr>
				</c:if>
				<%-- 추출방식 게시글 등록 --%>
				<c:if test="${genre eq 'extra' }">
					<tr>
						<th>추출방식</th>
						<td><input type="text" name="extra_genre"
							value="${dto.getExtra_genre() }" class="required" /></td>
					</tr>
				</c:if>
				<tr>
					<th>상세내용</th>
					<td><textarea rows="10" cols="30"
							class="form-control required" id="myEditor" name="cont">${dto.getInfo_cont() }</textarea></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td><c:if test="${!empty dto.getInfo_file() }">
							<input type="text" name="dtoFile" id="dtoFile"
								value="${dto.getInfo_file() }" readonly>
							<input type="button" value="첨부파일삭제" id="delete_btn" />
						</c:if> <input type="file" name="file" /></td>
				</tr>

				<tr align="center">
					<td colspan="2" align="center"><input type="button" value="작성"
						class="btn_submit btn btn-defult " />&nbsp; <input type="reset"
						value="재작성" class="btn btn-defult" />&nbsp; <c:if
							test="${!empty dto }">
							<input type="button" value="뒤로" onclick="history.back()"
								class="btn btn-defult " />
						</c:if> <c:if test="${empty dto }">
							<input type="button" value="목록으로" class="btn btn-defult "
								onclick="location.href='<%=request.getContextPath()%>/info_list.do?genre=${genre}'" />
						</c:if></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>