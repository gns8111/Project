<%@page import="com.groovy.dto.ZipcodeBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//�˻��� �ƴϰ� â�� open �������� search�� n�̰� �˻��϶� y
		String search = request.getParameter("search");
		Vector<ZipcodeBean> vlist = null;
		String doro = null;
		if(search.equals("y")){
			doro = request.getParameter("doro");
			vlist = mgr.zipcodeRead(doro);
			//out.print(vlist.size());
		}
		
%>
<html>
<head>
<title>�����ȣ �˻�</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loadSearch() {
		frm = document.zipFrm;
		if(frm.doro.value==""){
			alert("���θ��� �Է��ϼ���.");
			return;
		}
		frm.action = "zipSearch.jsp";
		frm.submit();
	}
	
	function sendAdd(zipcode, adds) {
		opener.document.regFrm.zipcode.value = zipcode;
		opener.document.regFrm.city.value = adds;
		self.close();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br />
		<form name="zipFrm" method="post">
			<table>
				<tr>
					<td>
					<br/>���θ� �Է� : 	<input name="doro">
						<input type="button" value="�˻�" 
						onclick="loadSearch()">
					</td>
				</tr>
				<!-- �˻���� ���� -->
				<%
						if(search.equals("y")){
							if(vlist.isEmpty()){
				%>
				<tr>
					<td align="center"><br/>�˻��� ����� �����ϴ�.</td>
				</tr>
				<%}else{%>
				<tr>
					<td align="center"><br/>�ذ˻� ��, �Ʒ� �����ȣ�� Ŭ���ϸ� �ڵ����� �Էµ˴ϴ�.</td>
				</tr>
				<%
						for(int i=0;i<vlist.size();i++){
							ZipcodeBean bean = vlist.get(i);
							String zipcode = bean.getZipcode();
							String sido = bean.getSido();
							String sigungu = bean.getSigungu();
							String dong = bean.getDong();
							String zibun1 = bean.getZibun1();
							String zibun2 = bean.getZibun2();
							String adds =sido+" "+sigungu+" "+dong+" "+zibun1+" - "+zibun2;
				%>
				<tr>
					<td><a href="#" onclick="javascript:sendAdd('<%=zipcode%>','<%=adds%>')">
					<%=zipcode+" "+adds%></a></td>
				</tr>
				<%			
							}//---for	
						}//---if2
					}//---if1
						
			%>
				<!-- �˻���� �� -->
				<tr>
					<td align="center"><br/>
					<a href="#" onClick="self.close()">�ݱ�</a></td>
				</tr>
			</table>
			<input type="hidden" name="search" value="y">
		</form>
	</div>
</body>
</html>