<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/bootstrap-3.4.1.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view.css" />
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5baaf50fbc8cf37b4ce0e496801f9251&libraries=services"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.alerts.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/jquery.alerts.css" />
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

</head>
<body>

	<div class="container">
		<div class="col-xs-12 col-sm-12 col-md-12 ">
			<hr width="100%" class="title" />
			<h2>JOIN</h2>
			<hr width="100%" class="title" />
		</div>
		<div class="col-xs-12 col-sm-12 col-md-12 " align="center">
			<form method="post" name="join_form">
				<div align="center">
					<table class="col-xs-5 col-md-5 col-lg-5 table table-line write"
						style="margin-left: 10%; margin-top: 2%; margin-bottom: 2%; width: 80%">
						<%-- ID 입력란 --%>
						<tr>
							<th>ID</th>
							<td><input type="text" id="m_id" name="m_id"
								placeholder="아이디를 입력하세요." class="required"> <input
								class="btn btn-defult" type="button" value="아이디중복체크"
								id="idcheck_btn" /> <br /> <%-- 경고문이 출력되는 위치 --%> <span
								id="idcheck"></span></td>
						</tr>

						<%-- PW 입력란 --%>
						<tr>
							<th rowspan="2">PASSWORD</th>
							<td><input type="password" name="m_pwd" id="pwd1"
								onkeyup="check_pw()" placeholder="패스워드를 입력하세요." class="required"></td>
						</tr>
						<tr>
							<td><input type="password" name="m_pwd2" id="pwd2"
								onkeyup="check_pw()" placeholder="한 번 더 입력하세요." class="required">
								<br /> <%-- 경고문이 출력되는 위치 --%> <span id="pwdcheck"></span></td>
						</tr>

						<%-- 닉네임 입력란 --%>
						<tr>
							<th>NICKNAME</th>
							<td><input type="text" name="m_nickname"
								placeholder="사용할 닉네임을 입력하세요." class="required"></td>
						</tr>

						<%-- 연락처 입력란 --%>
						<tr>
							<th>TEL</th>
							<td><input type='tel' name='tel1' size="3" placeholder="01*" />
								- <input type='tel' name='tel2' size="3" placeholder="****" />
								- <input type='tel' name='tel3' size="3" placeholder="****" /></td>
						</tr>

						<%-- EMAIL 입력란 --%>
						<tr>
							<th>EMAIL</th>
							<td><input type="text" name="m_email1" class="required"
								placeholder="이메일 아이디"> @ <select name="m_email2"
								class="required">
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.com">hanmail.com</option>
									<option value="nate.com">nate.com</option>
							</select></td>
						</tr>

						<%-- 주소 입력란 --%>
						<tr>
							<th rowspan="4">ADDR</th>
							<td><input type="text" name="postcode" readonly
								id="postcode" placeholder="우편번호">
								<button type="button" class="btn btn-defult"
									onclick="search_addr()">검색</button></td>
						</tr>

						<tr>
							<td><input type="text" name="address" readonly id="address"
								placeholder="기본 주소"></td>
						</tr>

						<tr>
							<td><input type="text" name="detailAddress"
								id="detailAddress" placeholder="상세 주소" class="required">
								<input type="text" id="extraAddress" placeholder="참고항목" readonly></td>
						</tr>
						<tr>
							<td>
								<div id="map"
									style="width: 100%; height: 300px; margin-top: 10px; display: none"></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">
								<h4><font color="red"> **회원 탈퇴 시 회사가 보유한 개인 정보가 삭제되지 않는 것을 원칙으로 합니다.** </font></h4>
							</td>
						</tr>

						<%-- 버튼 --%>
						<tr align="center">
							<td colspan="2" align="center"><input type="button"
								value="가입" class="btn_submit btn btn-defult "> &nbsp; <input
								type="reset" value="재작성" class="btn btn-defult" /> &nbsp; <input
								type="button" value="로그인"
								onclick="location.href='<%=request.getContextPath()%>/member.do'"
								class="btn btn-defult " /></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>

<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer"
	style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
	<img src="<%=request.getContextPath()%>/images/close.png"
		id="btnCloseLayer"
		style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
		onclick="closePost()" alt="닫기 버튼">
</div>

<script src="<%=request.getContextPath()%>/js/join.js"></script>

</body>
</html>