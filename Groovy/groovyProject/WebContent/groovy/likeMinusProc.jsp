<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <jsp:useBean id="pMgr" class="com.groovy.dao.PostMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	int p_index = Integer.parseInt(request.getParameter("p_index"));
	String id = (String)session.getAttribute("idKey"); //�α��� �Ŀ� ���ǿ� ����.
	pMgr.likeMinus(p_index, id);
	response.sendRedirect("home.jsp");
%>