<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="com.groovy.MailSend"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		boolean result = mgr.sendPwd(id, email);
		String msg = "�������� ����";
		if(result)
			msg = "�������� ����";
%>
<script>
	alert("<%=msg%>");
	location.href = "loginGroovy.jsp";
</script>