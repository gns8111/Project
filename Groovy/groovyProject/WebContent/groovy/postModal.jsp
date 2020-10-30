<%@page import="java.io.Console"%>
<%@page import="java.util.Vector"%>
<%@page import="com.groovy.dto.CommentBean"%>
<%@page import="com.groovy.dto.PostBean"%>
<%@page import="com.groovy.dto.MemberBean"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mMgr" class="com.groovy.dao.MemberMgr" />
<jsp:useBean id="pMgr" class="com.groovy.dao.PostMgr" />
<jsp:useBean id="cMgr" class="com.groovy.dao.CommentMgr" />
<jsp:useBean id="fMgr" class="com.groovy.dao.FollowMgr" />
<%
	String id = (String) session.getAttribute("idKey");
	String p_index = request.getParameter("p_index");
%>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=EUC-KR">
</head>
<style>

#tr1 {height: 0px;}

/* #fn { */
/* 	overflow: scroll; */
/* 	overflow-x: hidden; */
/* 	overflow-y: hidden; */
/* 	height: 300px; */
/* 	} */
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="style.css" />

<body onload="javascript:load();">
	<%	PostBean pbean = pMgr.readPost(Integer.parseInt(p_index));
		MemberBean mbean = mMgr.getMember(id);	%>
	<div style="padding: 0px;">
		<br>
		<div class="row">
			<div style="text-align: center; padding: 0px; margin-left: 15px;">
				<form action="#" method="post">
					<table>
						<tr>
							<td style="float: left; border: 10px">
								<div id="myCarousel" class="carousel slide" data-ride="carousel" style=" width: 450px; height: 450px;">
									<%if (pbean.getPhoto2() != null) {%>
									<ol class="carousel-indicators">
										<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
										<li data-target="#myCarousel" data-slide-to="1"></li>
										<%if (pbean.getPhoto3() != null) {%>
										<li data-target="#myCarousel" data-slide-to="2"></li>
										<%}%>
									</ol>
									<%} %>
									<div class="carousel-inner">
										<div class="item active">
								        	<img src="data/<%=pbean.getPhoto1()%>" style="width: 450px; height: 450px">
								      	</div>
										<%if (pbean.getPhoto2() != null) {%>
										<div class="item">
								        	<img src="data/<%=pbean.getPhoto2()%>" style="width: 450px; height: 450px">
									    </div>
										<%if (pbean.getPhoto3() != null) {%>
										<div class="item">
									    	<img src="data/<%=pbean.getPhoto3()%>" style="width: 450px; height: 450px">
									    </div>
										<%}%>
										<%}%>
									</div>
									<%if (pbean.getPhoto2() != null) {%>
									<a class="left carousel-control" href="#myCarousel" data-slide="prev">
								      <span class="glyphicon glyphicon-chevron-left"></span>
								      <span class="sr-only">Previous</span>
								    </a>
								    <a class="right carousel-control" href="#myCarousel" data-slide="next">
								      <span class="glyphicon glyphicon-chevron-right"></span>
								      <span class="sr-only">Next</span>
								    </a>
								    <%} %>
								</div>
							</td>
							
							<td>

								<table style="width:280px; height:450px; margin-left: 15px; margin-right: 10px;">
									<tr id = "tr1">
										<!-- 밑에 프로필 -->
										<td rowspan="1" style = "float: left;"><img src="data/<%=mbean.getProfile()%>.jpg" style="width: 40px; height: 40px; border-radius: 50%; margin: 20px;">
										<h2 style= "display: inline-block;"><%=pbean.getId()%></h2></td>
										
									</tr>
									<tr>
										<td colspan = "3">
										<div style= "padding-left:20px; overflow:auto; height: 250px;">
										<!-- 댓글부분 -->
										<%
											Vector<CommentBean> cvlist = cMgr.selectComment(pbean.getP_index());
										%>
										<%
											for (int j = 0; j < cvlist.size(); j++) {
													CommentBean cBean = cvlist.get(j);
													MemberBean cmBean = mMgr.getMember(cBean.getId());
													String cdate[] = cBean.getC_date().split("-");
										%>
										<div class="commentpeople" style= "text-align: left ">
											<img src="data/<%=cmBean.getProfile() + ".jpg"%>" style="width: 15px; height: 15px; border-radius: 5px;" />&nbsp;&nbsp;<label>
												<a href="mypage.jsp?id=<%=cmBean.getId()%>"><%=cmBean.getId()%></a>
											</label> &nbsp;&nbsp;<label><%=cBean.getC_contents()%></label>
											<br style="margin: 4px;">
										</div>
										<%}%>
										<!-- <div class="commentN" style="border-bottom: 5px;"></div> -->
										<!-- 댓글부분 끝 -->
										</div>
										</td>
									</tr>
									<tr>
										<td rowspan="1"><img src="image/redheart20px.png">
										<%=pMgr.likeInt(pbean.getP_index())%></td>
										<td rowspan="1"><img src="image/comment20px.png">
										<%=cMgr.commentInt(Integer.parseInt(p_index))%></td>
									</tr>
									<tr>
									<form>
										<td colspan="2" style = "padding-left: 3px;"><input class="form-control" placeholder="댓글을 입력 하세요." id="commentWrite"></td>
										<td><button class="btn btn-default" type="button"" 
									onclick="writeCmt('<%=p_index%>',this.form.commentWrite.value)">입력</button>
									</form>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
<a href="javascript:load()">닫기</a>
<form name="cmtFrm" method="post" action="commentProc1.jsp">
	<input type="hidden" name="p_index">
	<input type="hidden" name="comment">
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

<script>
function writeCmt(p_index, comment){
	document.cmtFrm.p_index.value = p_index;
	document.cmtFrm.comment.value = comment;
	document.cmtFrm.submit();
}
</script>

<script>
	function load() {
		location.reload();
	}
</script>
	</body>
</html>