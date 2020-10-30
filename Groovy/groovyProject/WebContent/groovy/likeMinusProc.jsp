<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <jsp:useBean id="pMgr" class="com.groovy.dao.PostMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	int p_index = Integer.parseInt(request.getParameter("p_index"));
	String id = (String)session.getAttribute("idKey"); //로그인 후에 세션에 들고옴.
	pMgr.likeMinus(p_index, id);
	response.sendRedirect("home.jsp");
%>