<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/map.css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5baaf50fbc8cf37b4ce0e496801f9251&libraries=services"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.js"></script>

</head>
<body>
	<div class="col-xs-10 col-sm-8 col-md-8 " style="width: 90%; margin-left: 5%;">
		<hr width="100%" class="title" />
		<h2>CAFE SEARCH</h2>
		<hr width="100%" class="title" />
	</div>
	<div class="map_wrap" style="width: 90%; margin-left: 5%;">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						키워드 : <input type="text" value="홍대 카페" id="keyword" size="15">
						<button type="submit">검색하기</button>
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

	<script src="<%=request.getContextPath()%>/js/map.js"></script>

</body>
</html>