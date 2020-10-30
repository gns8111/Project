<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fMgr" class = "com.groovy.dao.FollowMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idkey");
		String yid = request.getParameter("yid");
				
		fMgr.followCheckMod(yid, id);
		
		response.sendRedirect("yourpage.jsp?yid="+yid);
		
%>