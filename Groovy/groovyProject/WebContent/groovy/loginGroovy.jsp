<%@page import="java.util.function.Function"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
				
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Login V4</title>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon"  href="images/icons/favicon.ico"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 로그인 패스워드 텍스트 옆에 아이콘 부문 -->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<!-- 메일주소 입력 관련-->
	<script type="text/javascript"	src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	
	<script type="text/javascript" src="js/script.js">
		/* 
			선생님이 보내준 것 아이디 모달 확인창
			 $('.username_input').change(function () {
			      $('#id_check_sucess').hide();
			      $('.id_overlap_button').show();
			      $('.username_input').attr("check_result", "fail");
			    }) 
		 */
		
		 $('#selectEmail').change(function()
				 {$("#selectEmail option:selected").each(function () {if($(this).val()== '1'){
					 //직접입력일 경우 $("#str_email02").val(''); //값 초기화
					 $("#str_email02").attr("disabled",false); //활성화 }else{ //직접입력이 아닐경우
						 $("#str_email02").val($(this).text()); //선택값 입력
						 $("#str_email02").attr("disabled",true); //비활성화 }}); });
		</script>

		
	


</head>

<body>

	<div class="limiter">
		<!-- 이미지 꽉찬 화면 -->
		<div class="container-login100">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" name="loginFrm" method="post" action="loginProc.jsp">
					<span class="login100-form-title p-b-49"> Groovy </span>

					<div class="wrap-input100 validate-input m-b-23"
						data-validate="ID를 입력하세요.">
						<span class="label-input100"><strong>Username</strong></span> <input
							class="input100" type="text" name="username" placeholder="사용자 ID">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input"
						data-validate="비밀번호를 입력하세요.">
						<span class="label-input100"><strong>Password</strong></span> <input
							class="input100" type="password" name="pass" placeholder="비밀번호">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

					<div class="text-right p-t-8 p-b-31">
						<a href="#findPwd" data-toggle="modal"> Forgot password? </a>
					</div>


					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn"  id ="loginBtn" onclick="loginCheck()" >Login</button>
						</div>
					</div>

					<div class="flex-col-c p-t-155">
						<span class="txt1 p-b-17"> Or Sign Up Using </span> 
						<a class="txt2" data-toggle="modal" href="#joinModal">Sign Up</a>
					</div>
					</form>
					</div>

			<!-- 비밀번호 찾기 모달 -->
			<div class="modal fade" id="findPwd" data-backdrop="static"
				style="margin-top: 150px;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header"
							style="text-align: center; font-size: 30px;">
							<strong>비밀번호 찾기</strong>
							<button class="close" data-dismiss="modal">&times;</button>
							<hr />
							<div class="modal-body">
								<form name="postFrm" method="post" action="mailSendProc.jsp">
									<table class="table table-striped">
										<tr>
											<th>사용자ID</th>
											<td><input class="form-control" name="id"></td>
										</tr>
										<tr>
											<th>E-mail</th>
											<td><input class="form-control" type="email" name="email"></td>
										</tr>
									</table>
									<div class="modal-footer"><input type="submit"  class="btn btn-primary" value="메일전송"  id= "joinBtn" ></div>
								</form>
								
						</div>
					</div>
				</div>
			</div>
		</div>
			<!--Member Modal -->
					<div class="modal fade" id="joinModal" data-backdrop="static">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header"
									style="text-align: center; font-size: 30px;">
									<strong>Sign Up</strong>									
									<button class="close" data-dismiss="modal">&times;</button><hr/>
								<form name = "regFrm" method="post"  enctype="multipart/form-data" action="joinProc.jsp">
									<div class="row" >
									<span>profile</span>
								
									<img class="profile" src="aaa.png"  onclick="document.getElementById('file').click();"  name ="profile" id="blah">
 									<input type="file" name="profile" size="20" id="file" style="display:none;" onchange="readURL(this)"/>
 									</div>
								<div class="modal-body" style = "overflow: scroll; overflow-x: hidden; height:500px;">
										
										<!-- <form action="#" method="post">post:숨어서 넘어가는 방식 -->

									<table class="table table-striped">
										<tr id="text" >
										
										 	<th>사용자ID</th>
										 	<td><input type="text" class="form-control"  name="id" maxlength="20" style = "width: 70%; float: left"
										 	placeholder="ID 중복체크를 해주세요.">
											<!-- v-model="user.name" required -->
											<!-- <small class="text-muted">Your full legal name.</small> 
											    <div class="invalid-feedback"> 
											     Please enter your name. 
													</div> -->
													
													<input type = "button" class= "form-control"  value="중복확인" style = "width:30%;"
													onclick="javascript:idCheck(this.form.id.value)">
											</td>
										</tr>
										
										<tr id="text">
											<th>비밀번호</th>
											<td><input type="password" name="pwd"   class = "form-control"  maxlength="25"  
											placeholder="특수문자!@#, 대문자를 혼합하여 만들어 주세요." >
											</td>
										</tr>
										<tr id="text">
											<th>비밀번호 확인</th>
											<td><input type="password" name="pwd2" class = "form-control"	maxlength="25"
											placeholder="비밀번호를 한번 더 입력해주세요.">
											</td>
										</tr>
										<tr id="text">
											<th>이름</th>
											<td><input type="text"  class="form-control"  name="name" maxlength="20"
												placeholder="실명을 입력해주세요.">
											</td>
										</tr>
										<tr id="text">
											<th>닉네임</th>
											<td><input type="text" class = "form-control" name="nick"  maxlength="20"
													placeholder="그루비에서 사용할 닉네임을 만들어주세요!">
											</td>
										</tr>
									<tr id="text">
										<th>E-mail</th>
										
										<td><input class="form-control" type="email" name="email"></td>
									</tr>
									<tr id="text">
											<th>생년월일</th>
											<td>
									<%-- 	<select class="form-control"  id="birthday" style = "display:inline; width: 40%; float: left">
										<%
 											Calendar cal = Calendar.getInstance();
											for(int i = 1900; i<=cal.get(Calendar.YEAR);i++){%>
												<option><%=i%>년</option>
											 <%} %></select>
											<select class="form-control"  style = "display:inline; width: 30%; ">
											 <%for(int i =1;i<=12 ;i++){%>
												<option><%=i%>월</option>
												<%} %></select>
											 <select class="form-control"  style = "display:inline; width: 30%; float: right;">
											 <%for(int i =1;i<=31 ;i++){%>
												<option><%=i%>일</option>
												<%}%></select> --%>
												<input type="date" class = "form-control"  name="birthday" style = "text-align:center">
											</td>
										</tr>
										
										<tr>
										<th>H.P</th>
										<td><select class="form-control" style="display: inline; width: 20%;" name="fhp">
												<option value="010" selected="selected">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
										</select>
										
										<input type="number" class="form-control" name="hp"
											style="display: inline; width: 70%; float: none;"
											maxlength="8" oninput="numberMaxLength(this);"
											placeholder="연락처를 입력해주세요.">
										</td>
									</tr>
<%-- 										<% String hp1 = request.getParameter("fhp");
										String hp2 = request.getParameter("hp");
										String hp = hp1+hp2;%> --%>
										
										<tr>
											<th style="vertical-align: middle;">주소</th>
											<td>
											<input name="zipcode" id="zipcode" size="5" class = "form-control" style = "display: inline; width:70%;float:left">
											<input type="button"  class="btn btn-default" style = "display: inline; width:30%;" onclick="sample2_execDaumPostcode()" value="검색"/>
											<input name="address" id="address" size="40" class = "form-control">
											<input name="detailAddress"  id="detailAddress" size="40" class = "form-control" placeholder="상세주소를 입력해주세요.">
											<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
											<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" 
													onclick="closeDaumPostcode()" alt="닫기 버튼">
											
											</div>
											</td>
										</tr>

										<tr>
											<th>성별</th>
											<td><input type="radio" name="gender" value="남자" checked>male
													<input type="radio" name="gender" value="여자" >female
													</td>
										</tr>
										<tr id="text">
											<th>소개</th>
											<td><input type="text" id="intro" name = "intro" class="form-control"
												placeholder="간단한 소개글 입니다. 50자 이내로 작성해주세요."
												maxlength="50" ></td>
										</tr>
									</table>
											<input type="button"  class="btn btn-success" value="가입"  id= "joinBtn"
												onclick= "inputCheck()">
											<input type="reset" class="btn btn-info" value="리셋">
								</div>
								</form>
							</div>
							</div>
						</div>
					</div>
			</div>
		</div>
	
									
	<!-- 입력폼 유효성 체크 js -->
	<!-- <script src="jquery.validate.js"></script> -->
	<!------------------------------------------------------------------------------------------>
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src ="js/holder.js"></script>
	<script src ="js/bootstrap.js"></script>
	<!-- 다음 주소코드 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!--------------------------------------------------------------------------------------------------------->
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');
</script>


</body>
</html>