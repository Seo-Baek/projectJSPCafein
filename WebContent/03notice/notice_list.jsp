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
					<h2>공지사항 리스트</h2>
				<hr width="100%" class="title" />
			</div>
		</div>
		<div class=" col-md-1"></div>
		<div class="row">
		<form method="post" id="allowForm" action="allowCancle.do">
		<table class="col-md-8 col-lg-8 table table-hover table-line">
			<thead>
				<tr>
					<th width="10%" class="text-center">글번호</th>
					<th></th>
					<th width="33%" >글제목</th>
					<th width="12%" class="text-center">작성자</th>
					<th width="10%" class="text-center">조회수</th>
					 <th width="13%" class="text-center">게시일자</th>
					<th width="10%">게시취소</th>
				</tr>
			</thead>
			<c:if test="${!empty notice_list }">
				<c:forEach var = "i" begin = "0" end ="${notice_list.size()-1 }">
				<c:set var = "ndto" value="${notice_list.get(i) }" />
				<tr class="notice"style="background-color: beige;">
					<td>${ndto.getBoard_no() }</td>
					<td>
						<c:if test="${ndto.getBoard_file() != null }">
						<img class="${i }" 
						  onclick="location.href='getNoticeCont.do?board_no=${ndto.getBoard_no() }"
						  src="${ndto.getBoard_file() }"
							alt="thumbNail" />
						</c:if></td>
					<td class="align-none">
						<a 
						href='getNoticeCont.do?board_no=${ndto.getBoard_no() }'
						>${ndto.getBoard_title() }</a></td>
					<td>${ndto.getBoard_writer() }</td>
					<td>${ndto.getBoard_hit() }</td>
					<td>${ndto.getBoard_date().substring(0,10) }</td>
					<td>
						<input type="checkbox" name="is_check" id="che${i }"
												value="${ndto.getBoard_no() }">
						<input type="hidden" name="end" id="end" value="${notice_list.size()-1 }"/>
					</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty notice_list }">
				<tr>
					<td class="text-center" colspan="6">
						<br /><br />
						<h3>검색된 레코드가 없습니다.</h3>
						<br /><br />
					</td>
				</tr>
			</c:if>
		</table>
		<c:if test="${!empty notice_list }">
			<div class="col-xs-2 col-md-3 col-md-offset-9 col-xs-offset-10" align="right">	
			<input type="button" id="notAllow" value="게시취소" />
			</div>
		</c:if>
		</form>
		<br />
		<table class="col-md-8 col-lg-8 table table-hover table-line"
		 style="margin-top: 7%; margin-bottom: 4%;">
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
						<span class="${i }">${dto.getBoard_no() }</span>
					</td>
					<c:if test="${dto.getBoard_file() !=null }">
					<td>
						<img class="${i } "
						  onclick="location.href='getNoticeCont.do?board_no=${dto.getBoard_no() }'"
						  src="${dto.getBoard_file() }"
							alt="thumbNail" />
					</td>
					<td class="align-none">
						<a class="${i }"
						<%-- onclick="getCont(this.getAttribute('class'))" --%>
						 href="getNoticeCont.do?board_no=${dto.getBoard_no() }"
						>${dto.getBoard_title() }</a>
					</td>
					</c:if>
					<c:if test="${dto.getBoard_file() == null }">
					<td></td>
					<c:if test="${dto.getBoard_writer() != null }">
					<td style="text-align: left;">
						<a class="${i }" href='getNoticeCont.do?board_no=${dto.getBoard_no() }'>
						${dto.getBoard_title() }</a></td>
						</c:if>
						<c:if test="${dto.getBoard_writer() == null }">
							<td align="left">
							<a class="none"style="cursor:default;">${dto.getBoard_title() }</a></td>
						</c:if>
					</c:if>
					<c:if test="${dto.getBoard_writer() == null }">
					<td></td><td></td><td></td>
					</c:if>
					<c:if test="${dto.getBoard_writer() != null }">
					<td>${dto.getBoard_writer() }</td>
					<td>${dto.getBoard_hit() }</td>
					<td>${dto.getBoard_init().substring(0,10) }</td>
					</c:if>
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
			style="background-color: #FCFCFC; margin-bottom: 2%; border-radius: 3%;">
		<c:if test="${!empty board_list }">
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${page > block }">
					<li class="paginate_button previous">
						<a href="enter_list.do?page=1&&mno=-1&&accept=-1">◀◀</a>
					</li>
					<li>
						<a href=
						"enter_list.do?page=${startBlock-1 }&&mno=-1&&accept=-1"
							>◀</a>
					</li>
				</c:if>
				<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
					<li>
						<a href="enter_list.do?page=${i }&&mno=-1&&accept=-1"
						id="${i }">${i }</a>
					</li>
				</c:forEach>
				<c:if test="${endBlock < allPage }">
					<li>
						<a href="enter_list.do?page=${endBlock+1 }&&mno=-1&&accept=-1"
						>▶</a>
					</li>
					<li>
						<a href="enter_list.do?page=${allPage }&&mno=-1&&accept=-1">▶▶</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr style="width: 100%;" />
		</c:if>

		</div>
			
		</div>
			<div class="col-xs-2 col-md-3 col-md-offset-9 col-xs-offset-10">
			<input type="button" id="upload" value="글쓰기" />
			<input type="hidden" id="userNo" value="${userNo }" />
			</div>
			<input type="hidden" id="page" value="${page }"/>
<script type="text/javascript">
	$(function(){
		let page = $("#page").val();
		$("#"+page).attr('class','btn btn-default active');
		console.log(page);

		});		
	
	$("#notAllow").click(function(){
		let endNo = $("#end").val();
		let checked =$("input:checkbox[name=is_check]:checked").length;
		if(checked <= 0)
			alert('체크된 항목이 없습니다.');
		else
			$("#allowForm").submit();	
	});
	
	$("#upload").click(function(){
		if($("#userNo").val() == 0){
			alert('로그인 후 글 작성이 가능합니다.');
		} else {
			location.href="notice_write.do";
		}
		
	
	});		
	
		
</script>


</body>
</html>