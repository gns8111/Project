<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="com.groovy.dao.CommentMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	int index = Integer.parseInt(request.getParameter("p_index"));
	String comment = request.getParameter("comment");
	System.out.print(comment);
	String id = (String)session.getAttribute("idKey"); //로그인 후에 세션에 들고옴.
	cMgr.commentWrite(id, index, comment);
	response.sendRedirect("home.jsp");
%>