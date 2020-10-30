<%@page import="java.util.Random"%>
<%@page import="java.util.Vector"%>
<%@page import="com.groovy.dto.CommentBean"%>
<%@page import="com.groovy.dto.PostBean"%>
<%@page import="com.groovy.dto.MemberBean"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="com.groovy.dao.MemberMgr" />
<jsp:useBean id="pMgr" class="com.groovy.dao.PostMgr" />
<jsp:useBean id="cMgr" class="com.groovy.dao.CommentMgr" />
<jsp:useBean id="fMgr" class="com.groovy.dao.FollowMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	String id = (String)session.getAttribute("idKey");
	MemberBean mBean = mMgr.getMember(id);
	Random r = new Random();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/post.css">


<title>탐색하기</title>
<meta charset="EUC-KR">
<style>
body {
	font-family: '나눔고딕', 'Malgun Gothic', sans-serif;
}
/*---------------------------------------*/
article {
	display: inline-block;
	position: relative;
	transform: scale(1);
	-webkit-transform: scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transition: all 0.3s ease-in-out;
}

article:hover .thumbImg img {
	opacity: 0.5;
	transform: scale(1.2);
	-webkit-transform: scale(1.13);
	-moz-transform: scale(1.2);
	-ms-transform: scale(1.2);
	-o-transform: scale(1.2);
}

article:hover .links {
	opacity: 1;
}

.thumbImg img {
	opacity: 1;
	transition: .7s ease;
}

.icon {
	width: 20px;
	height: 20px;
}

.links {
	opacity: 0;
	position: absolute;
	text-align: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transition: .7s ease;
}
/*위에는 호버 밑에는 스타일시트*/
.out {
	width: 100%;
	text-align: center;
}

.in {
	display: inline-block;
}

.full {
	width: 100%;
	height: 100%;
}

.full1 {
	width: 60%;
	height: auto;
	text-align: center;
}

hr {
	width: 50%;
	height: 2px
}
/*모달*/
.profilebtn {
	display: block;
	width: 100px;
	height: 30px;
	background: #4ac4f3;
	text-decoration: none;
	text-align: center;
	color: #fff;
	border-radius: 50px;
	font-size: 10px;
}
.modal-content{
	background-color: white;
	margin: 15% auto;
	width: 20%;
	box-shadow: 0 0px 8px a rgba(0,0,0,0.2),0 7px 20px 0 rgba(0,0,0,0.17);
	animation-name:modalopen;
	animation-duration:0.8s;
	border-radius: 50px;
}

</style>
</head>
<body>
<!-- 네비게이션 바 시작 부분 -->
	<jsp:include page="navHeader.jsp"></jsp:include>
	<!-- 네비게이션 바 끝 부분 -->
<br>
<br>
<br>
<br>
		<div align="center">
			<table>
				<%
					Vector<String> vlist = pMgr.flistImgList(12, id);
					for (int i = 0; i < vlist.size(); i++) {
				%>
				<tr>
				<%
						String data[] = vlist.get(i).split("&");
						int cCnt =  cMgr.commentInt(Integer.parseInt(data[0]));
						int likeN = Integer.parseInt(data[2]);
				%>
					<td style='width: 290px; height: 290px;'>
						<article>
							<div class="thumbImg"><img src="data/data<%=r.nextInt(999)+1 %>.jpg" style="width: 270px; height:270px;"></div>
							<div class="links" style="text-align: center;">
								<br/> 
								<img src="image/redheart20px.png" class="icon"><%=likeN%>
								<img src="image/comment20px.png" class="icon"><%=cCnt%>
							</div>
						</article>
					</td>
					<%
								data = vlist.get(++i).split("&");
								 cCnt =  cMgr.commentInt(Integer.parseInt(data[0]));
								 likeN = Integer.parseInt(data[2]);	
					%>
					<td style='width: 290px; height: 290px;'>
						<article>
							<div class="thumbImg"><img src="data/data<%=r.nextInt(999)+1 %>.jpg" style="width: 270px; height:270px;"></div>
								<div class="links" style="text-align: center;">
									<br/> 
								<img src="image/redheart20px.png" class="icon">
								<%=likeN%> 
								<img src="image/comment20px.png" class="icon">
								<%=cCnt%>
							</div>
						</article>
					</td>
					<%
								 data = vlist.get(++i).split("&");
								 cCnt =  cMgr.commentInt(Integer.parseInt(data[0]));
								 likeN = Integer.parseInt(data[2]);	
					%>
					<td style='width: 290px; height: 290px;'>
						<article>
							<div class="thumbImg"><img src="data/data<%=r.nextInt(999)+1 %>.jpg" style="width: 270px; height:270px;"></div>
								<div class="links" style="text-align: center;">
									<br/> 
								<img src="image/redheart20px.png" class="icon">
								<%=likeN%> 
								<img src="image/comment20px.png" class="icon">
								<%=cCnt%>
							</div>
						</article>
					</td>
				</tr>
				<%}%>
			</table>
		</div>
	</div>
	
	<script>
	$(function() {
		var num = 3;
		$(window).scroll(function() {
							if ($(window).scrollTop() == $(document).height()- $(window).height()) {
								num = num + 9;
								$.ajax({
											url : 'list2.jsp?num=' + num+"&id=<%=id%>",type : 'get',success : function(t) {
												$(t).find("imglist").each(function() {
													var imgfile1 = $(this).find('imgfile1').text();
													var imgfile2 = $(this).find('imgfile2').text();
													var imgfile3 = $(this).find('imgfile3').text();
													var data1 = imgfile1.split("&");
													var data2 = imgfile2.split("&");
													var data3 = imgfile3.split("&");
													var code1 = "";
													var code2 = "";
													var code3 = "";
													code1 = "<table><tr><td style='width:290px; height:290px;'><article><div class='thumbImg'>";
													code2 = "<img src='data/data"+r.nextInt(999)+1+".jpg' style=\"width: 270px; height:270px;\"></div>";

													code2 += "<div class='links' style='text-align:center;'><br>";
													code2 += "<img src='image/redheart20px.png' class='icon'>"+data1[2];
													code2 += "<img src= 'image/comment20px.png'class='icon'>"+data1[0]+"</div></article>"

													code2 += "</td><td style='width:290px; height:290px;'><article><div class='thumbImg'>"
													code2 += "<img src='data/data"+r.nextInt(999)+1+".jpg' style=\"width: 270px; height:270px;\"></div>";

													code2 += "<div class='links' style='text-align:center;'><br>"
													code2 += "<img src='image/redheart20px.png' class='icon'>"+data2[2];
													code2 += "<img src= 'image/comment20px.png'class='icon'>"+data2[0]+"</div></article>"

													code2 += "</td><td style='width:290px; height:290px;'><article><div class='thumbImg'>"
													code2 += "<img src='data/data"+r.nextInt(999)+1+".jpg' style=\"width: 270px; height:270px;\"></div>";

													code2 += "<div class='links' style='text-align:center;'><br>"
													code2 += "<img src='image/redheart20px.png' class='icon'>"+data3[2];
													code2 += "<img src= 'image/comment20px.png'class='icon'>"+data3[0]+"</div></article>"

													code3 = "</td></tr></table>";
													$('<div align="center"></div>').html(code1	+ code2+ code3).appendTo('body');
													});
												}
								});
								}
							});
		});
</script>
	
</body>
</html>