<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="com.groovy.dao.MemberMgr"/>
<jsp:useBean id="bean" class="com.groovy.dto.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%		
		String id = (String)session.getAttribute("idkey");
		String gender = request.getParameter("gender");
		boolean result = mgr.updateMember(id);
		if(result){
			
%>
		<script>
			alert("회원정보를 수정 하였습니다.");
			location.href = "home.jsp";
		</script>
<%}else{%>
		<script>
			alert("회원정보를 수정에 실패 하였습니다.");
			history.back();
		</script>
<%}%>
