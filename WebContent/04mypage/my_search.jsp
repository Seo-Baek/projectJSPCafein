
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cafe :in 정보광장</title>
<link rel="stylesheet" href="css/bootstrap-3.4.1.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.js"></script>
<style type="text/css">
	
.title { 

	border-top:1px solid gray;
	margin: 3%;
 } 
 .table-line{
 	border-top: 1px solid #ddd;
 	border-bottom: 1px solid #ddd;
 }
 tr{
 	height: 50px;
 	text-align: center;
 	font-size:15px;	
 }
 th{
 	font-size: 15px;
 }
 .align-none{
 	text-align: left;
 }
 .contlist{
 	font-size: 20px;
 	
 }
 a{
 	color:navy;
 	cursor: pointer;
 }
 img{
 	cursor: pointer;
 }
 .re{
 	cursor: default;
 }
 .space{
 	cursor: default;
 }
 .none:hover{
 	text-decoration: none;
 }
</style>
</head>
<body>

	<div class="container">
		<div class="row" align="center">
			<div class="col-xs-1 col-sm-2 col-md-2 "></div>
			<div class="col-xs-10 col-sm-8 col-md-8 ">
				<hr width="100%" class="title" />
					<h2>나의 게시글 검색 리스트</h2>
				<hr width="100%" class="title" />
			</div>
		</div>
		<div class=" col-md-1"></div>
		<br /><br /><br />
		<div class="row">
			<div class="col-xs-10 col-sm-8 col-md-8" align="left">
				<h4><b style="font-size: 23px;"><i>${req_text }</i></b>(으)로 검색한 결과값</h4>
			</div>
			<div class="col-xs-1 col-sm-2 col-md-2 col-xs-offset-1 col-sm-offset-2 col-md-offset-2" align="right">
				<input type="button" class="btn btn-default" value="전체 목록"
					onclick="location.href='accept_list.do?mno=-1&&accept=1'" />
			</div>
		</div>
		<div class="row">
		<table class="col-md-8 col-lg-8 table table-hover table-line"
		 style=" margin-bottom: 4%;">
			<thead>
				<tr>
					<th width="10%" class="text-center">글번호</th>
					<th></th>
					<th width="45%" >글제목</th>
					<th width="16%" class="text-center">작성자</th>
					<th width="10%" class="text-center">조회수</th>
					 <th width="20%" class="text-center">작성일자</th>
				</tr>
			</thead>
				<c:if test="${!empty board_list }">
				<c:forEach var = "i" begin = "0" end ="${board_list.size()-1 }">
					<c:set var = "dto" value="${board_list.get(i) }" />
				<tr class="contlist">
					<td >
						${dto.getBoard_no() }
					</td>
					<c:if test="${dto.getBoard_file() !=null }">
					<td>
							<img class=${i } 
						  onclick="location.href='goWorMCont.do?board_no=${dto.getBoard_no() }&&category=mine"
						  src="${dto.getBoard_file() }"
							alt="thumbNail" />
					</td>
					<td class="align-none">
					<c:if test="${dto.getBoard_step()>0 }">
						<c:forEach begin="1" end="${dto.getBoard_step() }" var="j">
							<div class="space">&nbsp;&nbsp;</div>
							<c:if test="${j == dto.getBoard_step() }">
								<img class="re"src="./uploadFile/화살표.png" alt="(re:)"
									style="width: 10%; height: 10%;" />
							</c:if>
						</c:forEach>
					</c:if>
						<a  
						href="goWorMCont.do?board_no=${dto.getBoard_no() }&&category=mine"
						>${dto.getBoard_title() }</a>
					</td>
					</c:if>
					<c:if test="${dto.getBoard_file() == null }">
					<td></td>
					<td style="text-align: left;">
						
						<a href="goWorMCont.do?board_no=${dto.getBoard_no() }&&category=mine"
						><c:forEach begin="1" end="${dto.getBoard_step() }" var="i">
							&nbsp;&nbsp;
							<c:if test="${j == dto.getBoard_step() }">
								<img class="re"src="./uploadFile/화살표.png" alt="(re:)"
									style="width: 10%; height: 10%;" />
							</c:if>
						</c:forEach>${dto.getBoard_title() }</a></td>
					</c:if>
					<td>${dto.getBoard_writer() }</td>
					<td>${dto.getBoard_hit() }</td>
					<td>${dto.getBoard_date().substring(0,10) }</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty board_list }">
				<tr>
					<td class="text-center" colspan="6">
						<br /><br />
						<h3>검색된 레코드가 없습니다.</h3>
						<br /><br />
					</td>
				</tr>
			</c:if>
		</table>
		</div>
		<div class="col-md-3 col-lg-2"></div>
		<div class="col-md-7 col-lg-8" 
			style="background-color: #EBF5FF; margin-bottom: 2%; border-radius: 3%;">
		<c:if test="${!empty board_list }">
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${page > block }">
					<li class="paginate_button previous">
						<a 
						href="wait_search.do?page=1&&mno=${sessoionScope.userNo }&&accept=1&&req_box=${req_box}&&req_text=${req_text}">◀◀</a>
					</li>
					<li>
						<a href=
						"wait_search.do?page=${startBlock-1 }&&mno=${sessoionScope.userNo }&&accept=1&&req_box=${req_box}&&req_text=${req_text}"
							>◀</a>
					</li>
				</c:if>
				<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
					<li>
						<a href="wait_search.do?page=${i }&&mno=${sessoionScope.userNo }&&accept=1&&req_box=${req_box}&&req_text=${req_text}"
						id="${i }">${i }</a>
					</li>
				</c:forEach>
				<c:if test="${endBlock < allPage }">
					<li>
						<a href="wait_search.do?page=${endBlock+1 }&&mno=${sessoionScope.userNo }&&accept=1&&req_box=${req_box}&&req_text=${req_text}"
						>▶</a>
					</li>
					<li>
						<a href="wait_search.do?page=${allPage }&&mno=${sessoionScope.userNo }&&accept=1&&req_box=${req_box}&&req_text=${req_text}">▶▶</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr style="width: 100%;" />
		</c:if>

			<form method="post" action="<%= request.getContextPath() %>/wait_search.do">
			<select name="req_box" style="margin-left: 7%;margin-right: 1%; width: 15%;">
				<option value="title">글제목</option>
				<option value="cont">글내용</option>
				<option value="title+cont">제목+내용</option>
			</select>
			<input name="req_text" style="width: 59%; margin-right: 1%;" />
			<input type="submit" value="검색" style="margin-right: 1%;" />
			<input type="hidden" value="${sessionScope.userNo }" name="mno" />
			</form>
			<br />
		</div>
		</div>
			<div class="col-xs-2 col-md-3 col-md-offset-9 col-xs-offset-10">
			<input type="button" onclick="location.href='info_write.do'" value="글쓰기" />
			</div>
			<input type="hidden" id="page" value="${page }"/>
<script type="text/javascript">
	$(function(){
		let page = $("#page").val();
		$("#"+page).attr('class','btn btn-default active');
	});
</script>
</body>
</html>

</body>
</html>