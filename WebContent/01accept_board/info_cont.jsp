<%@page import="com.info.model.user.InfoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.alerts.css">
<link rel="stylesheet" href="css/bootstrap-3.4.1.css">
 <script src="https://kit.fontawesome.com/74c225bc71.js" crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<style type="text/css">

	a{
		color: #787878;
		text-shadow: 3px 3px 3px #dcdcdc;
		font-weight: bold;
		font-size: 16px;
	}
	pre { 
		 white-space: -moz-pre-wrap; /* Mozilla, supported since 1999 */ 
		white-space: -pre-wrap; /* Opera */ 
		white-space: -o-pre-wrap; /* Opera */ 
		white-space: pre-wrap; 
		/* CSS3 - Text module (Candidate Recommendation) http://www.w3.org/TR/css3-text/#white-space */ 
		word-wrap: break-word; /* IE 5.5+ */ 
	}
	
	table{
		border-top: 1px solid gray;	
		border-bottom: 1px solid gray;	
		width: 90%;
	}
	#cont{
		border-right: 1px solid gray;	
		border-left: 1px solid gray;	
		background-color: lightgray;	
	}
	#title{
		font-size: 18px;
		color: balck;
		font-weight: bold;
	}
	#info{
		font-size: 13px;
		color: gray;
	}
 	#date{
		font-size: 13px;
		color: gray;
	} 
	#ownComm{
		height: 80pt;
		width: 60%;
		padding-bottom: 4%;
		font-size: 50%;
	}
	pre{
		background-color: lightgray;
		border: none;
	}
	
	.preNext{
		cursor: pointer;
		height: 30pt;
		border-bottom : 1px dotted lightgray; 
	}
	.contbutton{
		background-color:#eee ;
	}
	.contbutton:hover{
		background-color: #DEDEDE;
		border-color: #b4b4b4;
	}
	
	ul{
		list-style: none;
	}
	li{
		float: left;
	}
	.comment{
		background-color: #eee;
	}
	.reply{
		padding-left: 8%;
		padding-right: 8%;
		padding-bottom: 2%;
	}
	.block{
		cursor: default;
		background-color: #eee;
		border:0.5px solid #b4b4b4;
	}
	.block:hover {
	cursor: default;
		background-color: #eee;
		border:0.5px solid #b4b4b4;
}
</style>
</head>
<body>
	
	<c:set var="dto" value="${Cont }" />
	<div class="container" align="center" style="margin-right: %15;">
		<br /><br /><br />
		<div align="right" style="padding-right: 3%;">
			<input class="btn contbutton" type="button" value="목록" 
				onclick="location.href='enter_list.do?mno=-1&accept=1'" />
		</div>
		<br />
		<div>
		<table cellspacing="0" id="cont" >
			<tr>	
				<td style="padding-top: 2%;">
					<input type="hidden" id="board_no" value="${dto.getBoard_no() }" />
					<input type="hidden" id="mno" name="mno"value="${dto.getBoard_mno() }" />
					<input type="hidden" id="userNo" value="${sessionScope.userNo }" />
					<input type="hidden" id="userName" value="${sessionScope.userName }" />
					<input type="hidden" id="pwd" value="${dto.getBoard_pwd() }" />
					<div class="col-xs-1" style="margin-left: -8%;"></div>
					<div class="col-xs-8">
						<h3>${dto.getBoard_title() }<small>|${cat } </small></h3>
					</div>
				</td>
			</tr>
			<tr>
				<td >
					<hr style="border-top: 1px solid gray; border-bottom: none" />
					<div class="col-xs-9 " align="left">
						<pre><label style="font-size: 14px; color: gray;"
						><i class="fab fa-gratipay" style="color: hotpink;"
						></i> ${dto.getBoard_writer() }</label></pre>
					</div>
					<div class="col-xs-2" style="margin-left: 5%;"align="right">
						<span id="date" style="font-size: 14px;">${dto.getBoard_date()}</span></div>
				</td>
			</tr>
			<tr>
				<td >				
					<br />
					<div class="col-xs-9 col-md-10 col-xs-offset-1 col-md-offset-1" 
						style="margin-bottom: 2%; " align="center">
					<pre style="height: auto; width: auto;font-size: 17px;">${dto.getBoard_cont() }</pre></div>
				</td>
			</tr>
			<tr >
				<td  align="center">
					<br /><br />
					
				</td>
			</tr>
			<tr>
					<td align="right">
						 <div style="margin-right: 3%;padding-bottom: 2%; padding-top: 2%;" >
						    <a 
						    href="https://creativecommons.org/licenses/by-nc-nd/4.0/deed.ko" target="_blank">
						           <i class="fab fa-creative-commons-by">저작자표시</i>
						           <i class="fab fa-creative-commons-nc">비영리</i>
						           <i class="fab fa-creative-commons-nd">변경금지</i> 
						    </a>
						    </div>
					</td>
				</tr>
			<tr>
				<td ><hr width="100%" /></td>
			</tr>
				<tr>
					<td >
						<div class="container reply">
					        <label for="content">comment</label>
					        <form name="commentInsertForm" id="commentInsertForm">
					            <div class="input-group">
					             <c:if test="${userName != null }">
					               <input type="hidden" name="mno" value="${userNo}"/>
					               <textarea class="form-control" rows="3" placeholder="당신의 코멘트를 적어주세요."
					               		name="commentInsertText" id="commentInsertText" style="height: 60pt;"></textarea>
					               <span class="input-group-btn">
					                    <button class="btn btn-default" type="button" id="commentInsertOk"
					                    	style="height: 60pt;">등록</button></span>	 
					              </c:if>
						       
								<c:if test="${userName == null }">
					               <input type="hidden" name="mno" value="${userNo}"/>
					               <textarea class="form-control block" rows="3" placeholder="로그인 후 작성이 가능합니다."
					               		readonly style="height: 60pt;"></textarea>
					               <span class="input-group-btn">
					                    <button class="btn btn-default block" type="button"
					                    	style="height: 60pt;">등록</button></span>
								</c:if>
					              </div>
							 </form>
						    </div>
					</td>
				</tr>
				<c:if test="${!empty Reply}">
				<c:forEach begin="0" end="${Reply.size()-1 }" var="index">
				<c:set var="reply" value="${Reply.get(index) }" />
				<tr>
					<td>
						<div class="contianer reply">
							<br />
								<c:if test="${reply.getDep() > 0 }">
								<c:forEach begin="1" end="${reply.getDep() }" var="i">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${i == reply.getDep() }">
											<i class="fas fa-chevron-right" style="margin-right:-1%;"></i>
									</c:if>
								</c:forEach>
								</c:if>
							<c:if test="${reply.getWriter() != '' }">
							<label style="padding-left: 2%;">
								<c:if test="${reply.getWriternum() <= 100}">운영자</c:if>
								<c:if test="${reply.getWriternum() > 100}">${reply.getWriter() }</c:if>
								</label><br />
							</c:if>
							<div class="row">
								
								<div class="col-xs-10" style="margin-left: ${3+reply.getDep()}%;">
									<input type="hidden" value="${reply.getRep_num() }" />
									<div id="rno${reply.getRep_num() }">
										<pre style="width: 115%;" class="rno${reply.getRep_num() }">${reply.getCont() }</pre>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12" align="right">
									<c:if test="${userNo == reply.getWriternum() }">
										<a style="cursor: pointer;" class="modi" id="btn${reply.getRep_num() }"
											>수정</a>&nbsp;&nbsp;<a style="cursor: pointer;"id="can${reply.getRep_num() }"
																							class="del">삭제</a>
									</c:if>
									<c:if test="${reply.getWriternum() != 0 }">
									<button class="btn btn-primary showTr" id="${reply.getRep_num() }">작성</button>
									</c:if>
								</div>
								<c:if test="${index < Reply.size()-1 }">
									<%-- <hr style="border-top: 1px dotted #eee; border-bottom: 1px dotted #eee;"/> --%>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="${reply.getRep_num() } hide" id="hide${index }">
					        <hr style="border-top: 1px dotted #eee;border-bottom: 3px dotted #eee;
					        			width: 80%;" />
						<div class="container reply" style="margin-left: 3%;">
					        <form  name="replyInsertForm" id="replyInsertForm${reply.getRep_num() }">
					            <div class="input-group" style="width: 90%;">
					            <div class="row" style="margin-left: 2%;">
					           	<i class="fas fa-chevron-right" style="width:3%;"></i><label>reply</label>
					           	</div>
					           	<div class="row">
					               <textarea class="form-control" id="replyInsertText${reply.getRep_num() }" 
					               		rows="3" placeholder="당신의 코멘트를 적어주세요."
					               		name="commentInsertText"style="width:80%;height: 60pt; margin-left:8%;"></textarea>
					               <span class="input-group-btn">
					                    <button class=" btn btn-default replyInsertBtn" type="button"
					                    	style="height: 60pt; margin-bottom: 2%;" id="init${reply.getRep_num()}">등록</button>
					                    	
					               </span>
					               </div>
					               </div>
						        </form>
						 </div>
						 </div>
					</td>
				</tr>
				<c:if test="${index < Reply.size()-1 }">
				<tr>
					<td><hr style="border-top: 1px dotted #eee; width: 90%;" /></td>
				</tr>
				</c:if>
				<c:if test="${index == Reply.size()-1 }">
				<tr>
					<td><hr style="border-top: 1px solid lightgray;" />
				</tr>
				</c:if>
				</c:forEach>
				</c:if>
		</table>
		<div class="row" style="margin-bottom: 3%;">
				<div class="col-sm-7 col-sm-offset-2" align="center">
					<input class="btn contbutton addre" type="button" value="답글 작성"
						style="margin-top: 1.9%; margin-left: 7.5%;" />
				</div>
			<c:if test="${dto.getBoard_mno() == sessionScope.userNo }">
			<div class="col-sm-2" style="padding-top: 1%; margin-left: 4%;">
				<input type="button" class="btn contbutton update" value="글수정" />
				<input type="button" class="btn contbutton delete"value="글삭제" />
			</div>
			
			</c:if>
		</div>
		<table class="table-hover"style="margin-bottom: 4%; margin-left: 5%;">	
			<thead>
				<tr style="margin-top: 5%; border-bottom: 1px solid gray; height: 20pt;">
					<th width="10%" class="text-center"></th>
					<th width="45%" >글제목</th>
					<th width="16%" class="text-center">작성자</th>
					<th width="10%" class="text-center">조회수</th>
					 <th width="20%" class="text-center">작성일자</th>
				</tr>
			</thead>
			<c:if test="${pre.getBoard_no() != 0 }">
			<c:if test="${pre.getBoard_title() != '삭제된 게시글입니다.' }">
				<tr class="text-align preNext"
					onclick="location.href='add1HitInfo.do?board_no=${pre.getBoard_no() }'">
					<td  width="10%"><img src="./uploadFile/pre_icon.gif">다음글</td>
					<td   width="45%" >${pre.getBoard_title() }</td>
					<td width="16%" class="text-center">${pre.getBoard_writer() }</td>
					<td width="10%" class="text-center">${pre.getBoard_hit() }</td>
					<td width="20%" class="text-center">${pre.getBoard_date() }</td>
				</tr>
			</c:if>
			<c:if test="${pre.getBoard_title() == '삭제된 게시글입니다.' }">
				<thead style="cursor: default;">
				<tr class="text-align preNext" style="cursor: default;">
					<td  width="10%" style="cursor: defult;"><img src="./uploadFile/pre_icon.gif">다음글</td>
					<td  align="left" colspan="4" style="cursor: default;">${pre.getBoard_title() }</td>
				</tr>
				</thead>
			</c:if>
			</c:if>
			<c:if test="${next.getBoard_no()!= 0 }">
			<c:if test="${next.getBoard_title() != '삭제된 게시글입니다.' }">
				<tr class="text-align preNext" 
					onclick="location.href='add1HitInfo.do?board_no=${pre.getBoard_no() }'">
					<td width="10%">
						<img src="./uploadFile/next_icon.gif">이전글</td>
					<td width="45%">${next.getBoard_title() }</td>
					<td width="16%" class="text-center">${next.getBoard_writer() }</td>
					<td  width="10%" class="text-center"s>${next.getBoard_hit() }</td>
					<td width="20%" class="text-center">${next.getBoard_date() }</td>
				</tr>
			</c:if>
			<c:if test="${next.getBoard_title() == '삭제된 게시글입니다.' }">
				<thead>
				<tr class="text-align preNext" >
					<td width="10%" style="cursor: default;">
						<img src="./uploadFile/next_icon.gif">이전글</td>
					<td align="left" colspan="4" style="cursor: default;">${next.getBoard_title() }</td>
				</tr>
				</thead>
			</c:if>
			</c:if>
		</table>
		</div>
	</div>

<script type="text/javascript">

	/* 대댓글창 hide & show 메소드 */
	$(".showTr").click(function(){
		let which = this.id;
		let user = $("#userName").val();
		if(user != ''){
			if($('#'+which).html() == "작성"){
				$("."+which).attr('class', which+" show");
				$('#'+which).html('작성취소');
			} else if($('#'+which).html()=='작성취소'){
				$("."+which).attr('class', which+" hide");
				$('#'+which).html('작성');			
			}
		} else {
			jAlert('댓글을 작성하려면 로그인이 필요합니다.');
		}
		});
	
		$(".update").click(function(){
				let board_no = $("#board_no").val();
				location.href="info_update.do?board_no="+board_no;			
		});
	
		$(".delete").click(function(){
			let board_no = $("#board_no").val();
			let board_pwd = $("#pwd").val();
			window.open("info_delete.do?board_no="+board_no+"&&category=accept","비밀번호 확인 - 삭제",
			"screenY=400, screenX=730,location=no,resizable=no,width=450,height=200");
		});
		
		/* $(".block").click(function(){
			let check = confirm('로그인하시겠습니까?');
			if(check == true)
				window.open('login.jsp');
		}); */
		
	/* 답글 생성 메소드 */
	$(".addre").click(function(){
		let board_no = $("#board_no").val();
		console.log(board_no);
		location.href="replyCont.do?board_no="+board_no;
	});
		
	/* 댓글 수정 메소드 */
	$(".modi").click(function() {
	      let comNo=this.id// 댓글 번호
	      let no = comNo.replace('btn','');
	      let name="rno"+no;
	      let cont = $("."+name).text();
	      if($("#btn"+no).text() == "수정"){
	    	  let comment = "<textarea rows='3'style='width:90%;height: 60pt; margin-left:2%;'"+
	    	  			"class='form-control "+name+"'>"+
				cont+"</textarea>";
			  $("#"+name).text('');
			  $("#"+name).append(comment);
			  $("#"+name).focus();
	    	  $("#btn"+no).text("확인");
	    	  $("#can"+no).text("취소");
	      } else if($("#btn"+no).text() == "확인"){
	    	  let realCont = $("."+name).val();
		      $.ajax({
		         type: "post",
		         url : "./ajax/comUp.jsp",
		         datatype : "jsp",
		         data :  {"comNo" 		:	no	,
		        	 	  "cont"		: 	realCont	
		        	 	  },
		         
		         success : function (data) {
		            if(data > 0){ // 수정에 성공한 경우
		               $.ajax({
		            	   type: "post",
		            	   url : "./ajax/call.jsp",
		            	   datatype: "jsp",
		            	   data : {"comNo"	: no},
		            	   success : function(data){
		            		   let comment = "<pre style='width: 115%;' class='"+        		   
		            		   name+"'>"+data+"</pre>";
		            		   $("#"+name).text('');
	            			   $("#"+name).append(comment);
	            	    	   $("#btn"+no).text("수정");
	            	    	   $("#can"+no).text("삭제");
		            	  } ,
		            	  error : function(){
		            		  jAlert("댓글을 불러오는데 실패했습니다.");
		            	  }
		               });
		            }else {    // 수정에 실패한 경우
		               jAlert("댓글 수정에 실패하였습니다.") ;            
		            }   
		            
		         },
		         error : function() {
		            jAlert("다시 시도해주세요.");
		         }
		         
		      });
      }
   });/*수정 end*/
   
   /* 댓글 삭제 메소드*/
   $(".del").click(function(){
	   let comNoId=this.id;// can+댓글번호
	   let comNo = comNoId.replace('can','');
	   let name="rno"+comNo;
	   let board_no = $("#board_no").val();
	   console.log(board_no);
	   if($("#can"+comNo).text() == "취소"){
		     let cont = $("."+name).text();
			 let comment = "<pre style='width: 115%;' class='"+        		   
      		   name+"'>"+cont+"</pre>";
			 $("#"+name).text('');
			 $("#"+name).append(comment);
			 $("#"+name).focus();
			 $("#btn"+comNo).text("수정");
			 $("#can"+comNo).text("삭제");
	   } else if($("#can"+comNo).text() == "삭제"){
		   let ok = jConfirm('댓글을 삭제하시겠습니까?','확인', function(result){
			   if(result){
				 let board_no = $("#board_no").val();
			  	 location.href="delRep.do?rep_no="+comNo+"&board_no="+board_no;			   
			   } else {
				   console.log(board_no);
			   }
			   
		   });
	   }
   });
   
   /* 댓글 생성 메소드 */
	$("#commentInsertOk").click(function(){
		if($("#commentInsertText").val() == ''){
			jAlert('글내용을 작성해주세요.');
		} else{
		let serializeData = $("#commentInsertForm").serialize();
		let board_no = $("#board_no").val();
		serializeData += '&board_no='+board_no;
		
		$.ajax({
			type: "post",
			url:  "insertComm.do",
			data: serializeData,
			success: function(data){
				if(data > 0){
				location.href="getInfo_Cont.do?board_no="+board_no;					
				} else {
					jAlert('댓글 등록 실패','실패');
				}
			},
			error : function(){
				jAlert('댓글을 작성하는 도중 오류가 발생했습니다.','Error');
			}
		});
		}
	}); 

   
   /* 대댓글 생성 메소드 */
   $(".replyInsertBtn").click(function(){
	 	let comId = this.id;
		let no = comId.replace('init','');
		console.log(no);
	   if($("#replyInsertText"+no).val() == ''){
			jAlert('글내용을 작성해주세요.');
		} else{
		console.log($("#replyInsertText"+no).val());
	    let serializeData = $("#replyInsertForm"+no).serialize();
		let board_no = $("#board_no").val();
		serializeData += '&board_no='+board_no;
		serializeData += '&commentParentNum='+no; 
		
		$.ajax({
			type: "post",
			url:  "insertComm.do",
			data: serializeData,
			success: function(data){
				if(data > 0){
				 location.href="getInfo_Cont.do?board_no="+board_no;		 		
				} else {
					jAlert('댓글 등록 실패','실패');
				}
			},
			error : function(){
				jAlert('댓글을 작성하는 도중 오류가 발생했습니다.','Error');
			} 
		});
		}
   });
</script>

</body>
</html>