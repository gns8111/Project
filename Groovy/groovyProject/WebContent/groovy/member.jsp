<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head>
<title>ȸ������</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		frm = document.regFrm;
		if(id==""){
			alert("���̵� �Է��ϼ���.");
			frm.id.focus();
			return;//function�� �����.
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
								<td colspan="3"><font color="#FFFFFF"><b>ȸ�� ����</b></font></td>
							</tr>
							<tr>
								<td width="20%">���̵�</td>
								<td width="50%">
									<input name="id" size="15"> 
									<input type="button" value="ID�ߺ�Ȯ��" onClick="idCheck(this.form.id.value)">
								</td>
								<td width="30%">���̵� ���� �ּ���.</td>
							</tr>
							<tr>
								<td>�̸�</td>
								<td><input name="name" size="15">
								</td>
								<td>�̸��� �����ּ���.</td>
							</tr>
								<tr>
								<td>�г���</td>
								<td><input name="nick" size="15">
								</td>
								<td>�г����� �����ּ���.</td>
							</tr>
							<tr>
								<td>�н�����</td>
								<td><input type="password" name="pwd" size="15"></td>
								<td>�н����带 �����ּ���.</td>
							</tr>
							<tr>
								<td>�н����� Ȯ��</td>
								<td><input type="password" name="repwd" size="15"></td>
								<td>�н����带 Ȯ���մϴ�.</td>
							</tr>
							<tr>
								<td>Email</td>
								<td><input name="email" size="30">
								</td>
								<td>�̸��ϸ� ���� �ּ���.</td>
							</tr>
							<tr>
								<td>��ȭ��ȣ</td>
								<td><input name="hp" size="30">
								</td>
								<td>��ȭ��ȣ�� ���� �ּ���.</td>
							</tr>
							<tr>
								<td>�����ȣ</td>
								<td><input name="zipcode" size="5" readonly>
									<input type="button" value="�����ȣã��" onClick="zipSearch()">
								</td>
								<td>�����ȣ�� �˻��ϼ���.</td>
							</tr>
							<tr>
								<td>�ּ�</td>
								<td><input name="city" size="45"></td>
								<td>�ּҸ� ���� �ּ���.</td>
							</tr>
							<tr>
								<td>���ɻ�</td>
								<td><input name="hobby" size="30">
								</td>
								<td>���ɻ縦 ���� �ּ���.</td>
							</tr>
							<tr>
								<td>����</td>
								<td>
									��<input type="radio" name="gender" value="1" checked> 
									��<input type="radio" name="gender" value="2">
								</td>
								<td>������ ���� �ϼ���.</td>
							</tr>
							<tr>
								<td>�Ұ�</td>
								<td><input name="intro" size="30">
								</td>
								<td>�Ұ��� ���ּ���.</td>
							</tr>																				
							<tr>
								<td colspan="3" align="center">
								   <input type="button" value="ȸ������" onclick="inputCheck()">
								    &nbsp; &nbsp; 
								    <input type="reset" value="�ٽþ���">
								    &nbsp; &nbsp; 
								    <input type="button" value="�α���" onClick="javascript:location.href='login.jsp'">
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