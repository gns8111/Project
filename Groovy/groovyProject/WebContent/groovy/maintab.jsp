<%@page import="com.groovy.dto.MemberBean"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		
		MemberBean bean = mgr.getMember(id);
		
%>


<html>
<head>
	<title>세팅 창</title>
	
	<link rel="stylesheet" href="css/updateformcss.css">
	<link rel="stylesheet" href="css/rangecss.css">
	<link rel="stylesheet" href="css/blockcss.css">
	<link rel="stylesheet" href="css/maintabcss.css">
	<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/home.css">
	
	<style>
		* {
			font-family: 'Do Hyeon', sans-serif;
		
		}
		td>label {
			font-size: 20px;
		}
		th,td {
			text-align: center;
			
		}
		
		#text> td {
			vertical-align: middle;
		}
		
		.profile{
			width: 177px;
			height: 177px;
			border: 5px double #A6A6A6;
			border-radius: 10px;
		}
	
	</style>
</head>

<body>
<jsp:include page = "navHeader.jsp"/>

	<div class="tab_content">
		<table>
		<input type="radio" name="tabmenu" id="tab01" checked>
		<label for="tab01"><h3>개인정보 수정</h3></label>
		</table>
		<table>
		<input type="radio" name="tabmenu" id="tab02">
		<label for="tab02"><h3>공개범위 및 차단</h3></label>
		</table>
		<table>
		<input type="radio" name="tabmenu" id="tab03">
		<label for="tab03"><h3>차단목록</h3></label>
		</table>
	<!-- 여기까지 라디오 버튼. 밑에부터 내용물 -->
	<div class="conbox con1" style ="margin-left: 100px;">
		<form name = "regFrm" role="form"  method="post" class="smart-form client-form"
								enctype="multipart/form-data" action="maintabProc.jsp" style="text-align: center;">
			<table class="table table-striped" style ="margin-left: auto;"><!-- post:숨어서 넘어가는 방식 -->
				
				<div class= "row" style=" text-align: center;">
					<h1>개인정보 수정</h1>
				</div>
				
			<tr id="text">
				<td>
					<label for="name">사용자ID</label>
				</td>
				<td>
					<label><%=bean.getId()%></label>
				</td>
			</tr>
						<tr id="text">
				<td>
					<label for="pwd">비밀번호</label>
				</td>
				<td>
					<input class="form-control" type="password" name="pwd" maxlength="25" >
				</td>
			</tr>
			<tr id="text">
				<td>
					<label for="name">이름</label>
				</td>
				<td>
					<input class="form-control" type="text" name="name" maxlength="20" value="<%=bean.getName()%>">
				</td>
			</tr>

			<tr id="text">
				<td>
					<label for="nick">닉네임</label>
				</td>
				<td>
					<input class="form-control" type="text" name="nick" maxlength="20" value ="<%=bean.getNick()%>">
				</td>
			</tr>
			<tr id="text">
				<td>
					<label for="email">E-mail</label>
				</td>
				<td>
					<input class="form-control" type="email" id="email" name="email" value="<%=bean.getEmail()%>">
				</td>
			</tr>
			
			<tr id="text">
				<td>
					<label for="birthday">생년월일</label>
				</td>
				<td>
					<input type="text" class = "form-control"  name="birthday" readonly value="<%=bean.getBirthday()%>">
				</td>
			</tr>
			
			<tr id="text">
				<td>
					<label for="phone" >H.P</label> 
				</td>
				<td>
					<!-- <select class="form-control" style ="display: inline; width: 30%;">
						<option>010</option>
						<option>011</option>
						<option>012</option>
						<option>013</option>
						<option>014</option>
						<option>015</option>
						<option>016</option>
						<option>017</option>
						<option>018</option>
						<option>019</option>
					</select> -->
					<input class="form-control" type="text" id="phone" name="hp"  style = "display: inline; "
					maxlength="14" value ="<%=bean.getHp()%>">
					</td>
			</tr>
			
						<tr id="text">
				<td>
					<label for="city">주소</label>
				</td>
				<td>
					<input name="zipcode" id="zipcode" size="5" class = "form-control" style = "display: inline; width:70%;float:left" value ="<%=bean.getZipcode()%>">
					<input type="button"  class="btn btn-default" style = "display: inline; width:30%;" onclick="sample2_execDaumPostcode()" value="검색"/>
					<input name="address" id="address" size="40" class = "form-control" value="<%=bean.getAddress()%>">
					<input name="detailAddress"  id="detailAddress" size="40" class = "form-control" value="<%=bean.getDetailAddress() %>" >
					<div id="layer" style="display:none; position:fixed; overflow:hidden; z-index:1; -webkit-overflow-scrolling:touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer; position:absolute;right:-3px;top:-3px;z-index:1" 
							onclick="closeDaumPostcode()" alt="닫기 버튼">
				</td>
			</tr>

			<tr id="text">
				<td id="gender_td" style ="vertical-align: middle;">
				<label>성별</label>
				</td>
				<td>
					<input type="radio" name="gender" value="1" <%if(bean.getGender()==1){%> checked <%}%> id="male" ><label for="male" id="choice" style ="padding: 0px;">male</label>
					<input type="radio" name="gender" value="2"<%if(bean.getGender()==2){%> checked <%}%> id="female" ><label for="female"  id="choice" style ="padding: 0px;">female</label>
				</td>
			</tr>

			<tr id="text">
				<td> 
					<label for="profile">프로필</label>
				</td>
				<td>
					<img class="profile" src="data/<%=bean.getProfile()%>.jpg"  onclick="document.getElementById('file').click();"  name ="profile" id="blah">
					<input type="file" name="profile" size="20" id="file" style="display:none;" onchange="readURL(this)"/>
				</td>
			</tr>



			<tr id="text">
				<td>
					<label for="intro">소개</label> 
				</td>
				<td>
					<input type="text" name="intro" class="form-control"
												placeholder="50자 이내로 작성해주세요."
												maxlength="50" value="<%=bean.getIntro()%>">
				</td>
			</tr>
				
		</table>
		
		<button class= "btn btn-success" name="submit"  style ="font-size: 20px;" onclick= "inputCheck()">저장</button>&nbsp;
					<button class= "btn btn-info" type="reset"  style ="font-size: 20px;">리셋</button>
		</form>

	</div>
	
	
	<div class="conbox con2" style ="margin-top: 50px;
		margin-left: 120px;">
		<div class="square">
		<div class="top">
			<h1>공 개 범 위</h1>
		</div>
		<form>
		<div class="main">
			<input type="radio" value="all" name="input" id="connectradio1" checked>
			&nbsp;<label for="connectradio1" id="contents1">전체공개</label>
			<label id="in">게시물 전체가 모든사람들한테 공개</label>
		</div>
		
		<div class="main">
			<input type="radio" value="friend" name="input" id="connectradio2">
			&nbsp;<label for="connectradio2" id="contents2">친구만 공개</label>
			<label id="in">남이 나를 팔로우해도 공개</label>
		</div>
		
		<div class="main">
			<input type="radio" value="block" name="input" id="connectradio3">
			&nbsp;<label for="connectradio3" id="contents3">비공개</label>
			<label id="in">모든 사람 비공개</label>
		</div>

		<div class="submitbutton">
			<input class ="btn btn-success" type="submit" value="저장" name="rangesubmit" style ="font-size: 20px;">
		</div>
</form>
		</div>
	</div><!-- 공개범위 -->
	<div class="conbox con3" style = "height: 500px; margin-top: 50px; margin-left: 100px;">
	
	<div class="block-list">
		<h1 style="text-align: center;">차 단 목 록</h1>
	</div>

	<table class="table table-striped">
	<tr>
		<th>이수석</th>
		<td><label id="blockdate">2019.11.03</label></td>
		<td><input type="button" value="차단 해제" name="blockcancel" ></td>
	</tr>
	
	
	<tr>
		<th>강동훈</th>
		<td><label id="blockdate">2019.11.15</label></td>
		<td><input type="button" value="차단 해제" name="blockcancel"></td>
	</tr>

	
	<tr>
		<th>신정훈</th>
		<td><label id="blockdate">2019.11.15</label></td>
		<td><input type="button" value="차단 해제" name="blockcancel" ></td>
	</tr>

	<tr>
		<th>정동진</th>
		<td><label id="blockdate">2019.11.15</label></td>
		<td><input type="button" value="차단 해제" name="blockcancel"></td>
	</tr>

	</table>
	</div><!-- 차단목록 -->
	</div>

	
	<script type="text/javascript" src="script.js"></script>
	<!-- 다음 주소코드 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!--------------------------------------------------------------------------------------------------------->
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');
</script>
	
	
</body>


</html>