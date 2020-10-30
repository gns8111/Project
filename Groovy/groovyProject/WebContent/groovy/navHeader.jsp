<%@page import="com.groovy.dao.FollowMgr"%>
<%@page import="com.groovy.dto.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="fMgr" class = "com.groovy.dao.FollowMgr"/>
<jsp:useBean id="mMgr" class = "com.groovy.dao.MemberMgr"/>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		String yid = request.getParameter("yid");
		MemberBean mBean = mMgr.getMember(yid);
		
%>

<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="style.css" />
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|&display=swap" rel="stylesheet">
<style>

* {font-family: 'Do Hyeon', sans-serif;}
	
a {
text-decoration: none;
}
	
#fn {
overflow: scroll;
overflow-x: hidden;
height: 300px;
}
	
	
	 
</style>
</head>
<body>
<!-- 네비게이션 바 시작 부분 -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid" style = "margin-left: 250px; margin-right: 250px;">
			<div class="navbar-header" style="float: left;">
				<a class="navbar-brand" href="home.jsp" style="color:#5de0a1; font-size: 25px;"><b>Groovy</b></a>
			</div>
			<form class="form-inline" action="#" style = "margin-top:10px;text-align: center;">
					<input class="form-control" type="text" placeholder="무엇을 검색하시겠어요 ?" />
					<button class="btn btn-success" type="submit">검색</button>
							&nbsp;&nbsp;&nbsp;
							
							
							
						<a href="find.jsp"><img src="image\compass24px.png" /></a>

						<%-- <div class="dropdown">																	&nbsp;&nbsp;&nbsp;&nbsp; 
							<button class="dropdown-toggle" type="button" id="about-us" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border: none;">
								<img src="image\blackheart20px.png" />
							</button>
							<ul class="dropdown-menu" aria-labelledby="about-us" style="overflow: auto;">
							<li class="dropdown-header">알림</li>
							<%/*여기 부분에서 for 문으로 알림 온만큼 반복함*/ %>
							<li role="separator" class="divider"></li>
								<li><a href="#">강동훈 님께서 좋아요를 누르셨습니다.</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">신정훈 님께서 댓글을 남기셨습니다.</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">이수석 님께서 좋아요를 누르셨습니다.</a></li>
								<li role="separator" class="divider"></li>
								<%/*반복 끝남.*/ %>
							</ul>
						</div> --%>

					<div class="dropdown" >
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="dropdown-toggle" id="about-us"
							data-toggle="dropdown" >
							<img src="image\blackheart20px.png" />
						</button>
						
						<div class="dropdown-content"  id = "fn" >
					<%
							Vector<String> vlist = fMgr.followNotification(id);
							for(int i=0;i<vlist.size();i++){%>
							<a href="yourpage.jsp?yid=<%=vlist.get(i) %>"><%=vlist.get(i)%>님이 팔로우를 하셨습니다.</a>
					<%}%>
						</div>
				</div>
				
					&nbsp;&nbsp;&nbsp;&nbsp; 
					<a href="mypage.jsp"><img src="image\user24px.png" /></a> 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="maintab.jsp"><img src="image\settings20px.png" /></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href = "logoutProc.jsp"><img src ="image\logout24px.png"/></a>
			</form>
			
		</div>
	</nav>
	
		<script>
		function followChk() {
			location.href="navProc.jsp?yid=<%=yid%>";
		}
	
		</script>
	</body>
</html>