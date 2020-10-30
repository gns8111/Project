<!-- memberProc.jsp -->
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class = "com.groovy.dao.MemberMgr"/>
<jsp:useBean id="bean" class = "com.groovy.dto.MemberBean"/>
<jsp:setProperty property = "*" name = "bean"/>
<%
		request.setCharacterEncoding("UTF-8");
		String hp1 = (String)request.getParameter("fhp");
		System.out.println(hp1);
		String hp2 = request.getParameter("hp");
		/* String hp3 = request.getParameter("hp").substring(4, 7); */
		String hp = hp1+"-"+hp2+"-"; //폰번호 합치기 */
		
		
		boolean result = mgr.insertMember(request);
		String msg = "회원가입에 실패하였습니다.";
		String url = "loginGroovy.jsp";
		
		if(result) {
			msg = "Groovy의 회원이 되신 걸 환영합니다.";
		}
 	
		
		
		
		
		String gender = request.getParameter("gender");
		String email1 = request.getParameter("str_email01");
		String email2 = request.getParameter("str_email02");
		String email = email1+"@"+email2;//메일주소  select box 합치기
		
		
		
		
		/* bean.setHp(hp); */
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>