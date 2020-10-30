<!-- postProc.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mgr" class = "com.groovy.dao.PostMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	
	String msg = "게시물이 작성 되었습니다.";
	
	boolean result = mgr.insertContent(request);
	
	String url = "home.jsp";
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
		