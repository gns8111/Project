<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<%
	  request.setCharacterEncoding("EUC-KR");
	  String cPath = request.getContextPath();
	  
	  /*
	 	request.getContextPath()�� ������Ʈ�� Context path���� ��ȯ�Ѵ�.
		��û : http://localhost:8080/example/test.jsp 
		���ϰ� : /example
	 */
		
	  String id = request.getParameter("username");
	  String pwd = request.getParameter("pass");
	  String msg = "�α��ο� ���� �Ͽ����ϴ�.";
	  
	  boolean result = mgr.loginMember(id, pwd);
	  String url = "loginGroovy.jsp";
	  
	  
	  if(result){
	    session.setAttribute("idKey",id);
	    msg = "�α��ο� ���� �Ͽ����ϴ�.";
	    url = "home.jsp";
	  }
	  
	  
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>