<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<%
	  request.setCharacterEncoding("EUC-KR");
	  String cPath = request.getContextPath();
	  
	  /*
	 	request.getContextPath()는 프로젝트의 Context path명을 반환한다.
		요청 : http://localhost:8080/example/test.jsp 
		리턴값 : /example
	 */
		
	  String id = request.getParameter("username");
	  String pwd = request.getParameter("pass");
	  String msg = "로그인에 실패 하였습니다.";
	  
	  boolean result = mgr.loginMember(id, pwd);
	  String url = "loginGroovy.jsp";
	  
	  
	  if(result){
	    session.setAttribute("idKey",id);
	    msg = "로그인에 성공 하였습니다.";
	    url = "home.jsp";
	  }
	  
	  
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>