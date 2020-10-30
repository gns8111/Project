<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head>
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		frm = document.regFrm;
		if(id==""){
			alert("아이디를 입력하세요.");
			frm.id.focus();
			return;//function을 벗어난다.
		}
		url = "idCheck.jsp?id="+id;
		window.open(url,"IDCheck","width=300,height=150");
	}
	
	function zipSearch() {
		url = "zipSearch.jsp?search=n";
		window.open(url,"ZipCodeSearch",
				"width=500,height=300,scrollbars=yes");
	}
	
</script>
</head>
<body bgcolor="#FFFFCC" onLoad="regFrm.id.focus()">
	<div align="center">
		<br /><br />
		<form name="regFrm" method="post" action="memberProc.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>회원 가입</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="id" size="15"> 
									<input type="button" value="ID중복확인" onClick="idCheck(this.form.id.value)">
								</td>
								<td width="30%">아이디를 적어 주세요.</td>
							</tr>
							<tr>
								<td>이름</td>
								<td><input name="name" size="15">
								</td>
								<td>이름을 적어주세요.</td>
							</tr>
								<tr>
								<td>닉네임</td>
								<td><input name="nick" size="15">
								</td>
								<td>닉네임을 적어주세요.</td>
							</tr>
							<tr>
								<td>패스워드</td>
								<td><input type="password" name="pwd" size="15"></td>
								<td>패스워드를 적어주세요.</td>
							</tr>
							<tr>
								<td>패스워드 확인</td>
								<td><input type="password" name="repwd" size="15"></td>
								<td>패스워드를 확인합니다.</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="email" size="30">
								</td>
								<td>이메일를 적어 주세요.</td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input name="hp" size="30">
								</td>
								<td>전화번호를 적어 주세요.</td>
							</tr>
							<tr>
								<td>우편번호</td>
								<td><input name="zipcode" size="5" readonly>
									<input type="button" value="우편번호찾기" onClick="zipSearch()">
								</td>
								<td>우편번호를 검색하세요.</td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input name="city" size="45"></td>
								<td>주소를 적어 주세요.</td>
							</tr>
							<tr>
								<td>관심사</td>
								<td><input name="hobby" size="30">
								</td>
								<td>관심사를 적어 주세요.</td>
							</tr>
							<tr>
								<td>성별</td>
								<td>
									남<input type="radio" name="gender" value="1" checked> 
									여<input type="radio" name="gender" value="2">
								</td>
								<td>성별을 선택 하세요.</td>
							</tr>
							<tr>
								<td>소개</td>
								<td><input name="intro" size="30">
								</td>
								<td>소개를 해주세요.</td>
							</tr>																				
							<tr>
								<td colspan="3" align="center">
								   <input type="button" value="회원가입" onclick="inputCheck()">
								    &nbsp; &nbsp; 
								    <input type="reset" value="다시쓰기">
								    &nbsp; &nbsp; 
								    <input type="button" value="로그인" onClick="javascript:location.href='login.jsp'">
								 </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>