<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap-3.4.1.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js">
	/* Bootstrap CDN JavaScript */
</script>
<script src="<%=request.getContextPath()%>/js/info.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />

<script type="text/javascript">
//iframe resize
function autoResize() {
	
	var height = listview.document.body.scrollHeight;
	var iframeHeight = (height * 1.1) + 'px';
	document.getElementById("listview").style.height = iframeHeight;
	var vheight = parent.view.document.body.scrollHeight;
	var viframeHeight = (height * 1.1) + 'px';
	parent.document.getElementById("view").style.height = iframeHeight;
	
	$(window).resize(function() {
		var height = listview.document.body.scrollHeight;
		var iframeHeight = (height * 1.1) + 'px';
		document.getElementById("listview").style.height = iframeHeight;
		var vheight = parent.view.document.body.scrollHeight;
		var viframeHeight = (height * 1.1) + 'px';
		parent.document.getElementById("view").style.height = iframeHeight;
	});
}
</script>

</head>
<body>
	<div style="height: 100%; overflow: hidden;">
		<div class="col-sm-2">
			<div class="panel panel-default">
				<div class="panel-heading">Board</div>
				<div class="panel-body" align="left">
					<ul style="list-style-type: none; padding-inline-start: 0px;">
						<li><a
							href="<%=request.getContextPath()%>/info_list.do?genre=info"
							target="listview">INFORMATION</a></li>
						<li><a
							href="<%=request.getContextPath()%>/info_list.do?genre=beans"
							target="listview">BEANS</a></li>
						<li><a
							href="<%=request.getContextPath()%>/info_list.do?genre=country"
							target="listview">COUNTRY</a></li>
						<li><a
							href="<%=request.getContextPath()%>/info_list.do?genre=extra"
							target="listview">EXTRACTION</a></li>
						<li><a href="<%=request.getContextPath()%>/cff_list.do"
							target="listview">COFFEE FOOD</a></li>
						<li><a href="<%=request.getContextPath()%>/info_find.do"
							target="listview">CAFE SEARCH</a></li>
					</ul>
				</div>
				<div class="panel-footer" align="center">
					<input type="text" id="find_name" style="width: 100%;"> <input
						type="button" class="btn btn-defult" style="width: 100%;"
						onclick="searchList()" value="검색" />
				</div>
			</div>
		</div>

		<div class="col-sm-10">
			<iframe src="<%=request.getContextPath()%>/info_list.do?genre=info" name="listview"
				id="listview"
				style="display: block; width: 100%; height: 100vh; border: 0; scrolling: no;"
				onload="autoResize()"> </iframe>
		</div>
	</div>

</body>
</html>