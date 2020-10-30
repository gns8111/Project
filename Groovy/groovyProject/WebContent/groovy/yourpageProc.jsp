<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="fMgr" class="com.groovy.dao.FollowMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		String yid = request.getParameter("yid");
		String mode = request.getParameter("mode");
		if(mode.equals("true")){
			fMgr.follow(id, yid);
		}else{
			fMgr.followCancel(id, yid);
		}
		response.sendRedirect("yourpage.jsp?yid="+yid);
%>


