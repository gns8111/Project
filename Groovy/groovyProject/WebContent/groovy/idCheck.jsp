<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		boolean result = mgr.checkId(id);
		//out.println(result);
%>
<html>
<head>
<title>ID 중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#F6F6F6">
<div align="center">
<br/><b><%=id%></b>
<%
		if(result){
			out.println("는 이미 존재하는 ID입니다.<p/>");
		}else{
			out.println("는 사용 가능합니다.<p/>");
		}
%>
<a href="#" onclick="self.close()">닫기</a>
</div>
</body>
</html>