<%@page import="java.util.Vector"%>
<%@page import="com.groovy.dto.CommentBean"%>
<%@page import="com.groovy.dto.PostBean"%>
<%@page import="com.groovy.dto.MemberBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="com.groovy.dao.MemberMgr" />
<jsp:useBean id="pMgr" class="com.groovy.dao.PostMgr" />
<jsp:useBean id="cMgr" class="com.groovy.dao.CommentMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey"); //로그인 후에 세션에 들고옴.
%>
<!-- 부트스트랩 가져오기  -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/home.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">

<title>Home</title>

</head>
<body>
	 <!-- 네비게이션 바 시작 부분 -->
	<jsp:include page = "navHeader.jsp"/>
	<!-- 네비게이션 바 끝 부분 -->

	<!-- 게시물 작성 시작 부분 Modal -->
	
	<br />
	<br />
	<br />
	<br />
	<div class="postCreateDiv">
	<input class="postCreateBtn" type="image" src="image/more.png" data-toggle="modal" data-target="#flipFlop">
	</div>
	<div class="modal fade" id="flipFlop" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document" style="text-align: center;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modalLabel">게시물 작성하기</h4>
				</div>
					<div class="modal-body">
					<form name="postFrm" method="post" action="homeProc.jsp" enctype="multipart/form-data">
						<textarea rows="10" cols="50" name="p_contents" placeholder="할 말이 있으신가요?" 
						style="resize: none; font-size:18px; margin:5px; padding:12px; width: 100%"></textarea>
						<hr> <!-- 게시물 업로드 -->
						<div class="row">
							<div class="col-sm-2" style="margin-right:90px; margin-left:5px;" id="previewid1">
								<img class="profile1" src="image/previewjpg.jpg" onclick="document.getElementById('profile1').click();" height="177px" width="177px" name ="profile1" id="changeimage1">
								<input type="file" name ="profile1" id="profile1" style="display: none;" onchange="myfun1()">
							</div>
							<div class="col-sm-2" style="margin-right:90px;" id="previewid2">
								<img class="profile2" src="image/previewjpg.jpg" onclick="document.getElementById('profile2').click()"; height="177px" width="177px" name ="profile2" id="changeimage2">
								<input type="file" name ="profile2" id="profile2" style="display: none;" onchange="myfun2()">
							</div>
							<div class="col-sm-2" style="margin-right:90px;" id="previewid3">
								<img class="profile3" src="image/previewjpg.jpg" onclick="document.getElementById('profile3').click()"; height="177px" width="177px" name ="profile3" id="changeimage3">
								<input type="file" name ="profile3" id="profile3" style="display: none;" onchange="myfun3()">			
							</div>
						</div>
						<script> 
						var i = 0;
						function myfun1() { // 사진 1번째 자리
							i++;

							var x = document.getElementById("profile1").files[0];
							var currentimage1 = document.getElementById("changeimage1");
							var reader =   new FileReader();
									 
							reader.onload = function() {
								if(i == "1") { currentimage1.src = reader.result; }
								if(i == "2") { currentimage2.src = reader.result; }
								if(i == "3") { currentimage3.src = reader.result; }
							} 
							reader.readAsDataURL(x);
						}
						
						function myfun2() { // 사진 2번째 자리
							i++;
	
							var x = document.getElementById("profile2").files[0];
							var currentimage2 = document.getElementById("changeimage2");
							var reader =   new FileReader();
									 
							reader.onload = function() {
								if(i == "1") { currentimage1.src = reader.result; }
								if(i == "2") { currentimage2.src = reader.result; }
								if(i == "3") { currentimage3.src = reader.result; }
							} 
							reader.readAsDataURL(x);
						}
						
						function myfun3() { // 사진 3번째 자리
							i++;
	
							var x = document.getElementById("profile3").files[0];
							var currentimage3 = document.getElementById("changeimage3");
							var reader =   new FileReader();
									 
							reader.onload = function() {
								if(i == "1") { currentimage1.src = reader.result; }
								if(i == "2") { currentimage2.src = reader.result; }
								if(i == "3") { currentimage3.src = reader.result; }
							} 
							reader.readAsDataURL(x);
						}
						</script>
						<hr>		
						<input type="text" name="tag" placeholder="태그란입니다. ex)여행#감성#힐링" style ="width:95%; height:3%; padding:3px;">
							
					</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-success" data-dismiss="modal" onclick="writePost()" value="작성">
					<input type="reset" class="btn btn-secondary" data-dismiss="modal" value="닫기" onclick="location.reload()">
				</div>
					<input type="hidden" name="id" value="<%=id%>">
			</form>
			</div>
		</div>
	</div>
	<!-- 게시물 작성 끝 부분 -->

	<!-- 게시물 시작 부분 -->
	<div class="containerOut col-lg-6 col-lg-push-3" style="margin-top: 10px; ">
		<%
			Vector<PostBean> pvlist = pMgr.selectPost(id);
		%>
		<%
			for (int i = 0; i < pvlist.size(); i++) {
				PostBean pBean = pvlist.get(i);
				MemberBean mBean = mMgr.getMember(pBean.getId());
				String date[] = pBean.getP_date().split("-");
		%>
		<div class="container">
			<div class="postheader">
				<a href="yourpage.jsp?yid=<%=mBean.getId()%>"><img src="data/<%=mBean.getProfile()%>" id="smallpro" /></a> 
				<label><%=mBean.getId()%></label>
				<label id="personID"><%=mBean.getEmail()%></label>
				<label id="personDate"><%=date[0]%>/<%=date[1]%>/<%=date[2]%></label>
				
				<!-- 이미지, 아이디@닉네임, 작성날짜 이 3개가 postheader안에 있고,
					아이디@닉네임, 작성날짜는 각각의 label안에 있음. -->

				<!-- 메뉴버튼(드롭다운) -->
				<div class="dropdown-m">
				  <img src="image/icons/block20px.png">
				  <div>
				    <a href="#">차단하기</a>
				  </div>
				</div>
			</div>
			<!-- postheader여기까지 -->
		<hr>
		
		<!-- 게시물 내용 (사진) -->
         <div id="postcenter">
            
            <div id="view">
            <ul class="wrap<%=i%>"> <!-- 캐러셀, 캐러셀 안 이미지 크기(px) -->
               <li><img src="data/<%=pBean.getPhoto1()%>"></li>
               <% if (pBean.getPhoto2() != null && pBean.getPhoto2() != "") { %>
               <li><img src="data/<%=pBean.getPhoto2()%>"></li>
               <% } %>   
               <% if (pBean.getPhoto3() != null && pBean.getPhoto3() != "") { %>
               <li><img src="data/<%=pBean.getPhoto3()%>"></li>
               <% } %>
            </ul>
            <ul class="btn<%=i%>"> <!-- 캐러셀 버튼 -->
               <li class="prev<%=i%>" style="background-color: rgba( 255, 255, 255, 0.2 ); height:22px; width:22px; border-radius:50%">
               <img src="image/prevbtn.png"></li>
               <li class="next<%=i%>" style="background-color: rgba( 255, 255, 255, 0.2 ); height:22px; width:22px; border-radius:50%">
               <img src="image/nextbtn.png"></li>
            </ul>
            </div>
            <div  style = "text-align: center;"><label><%=pBean.getP_contents()%></label></div></br>
         </div>
            
   <style>
      
      .wrap<%=i%> { width:2500px; }
      .wrap<%=i%> li { width:650px; height:550px; float:left; }
      .wrap<%=i%> li img { width:100%; height:70%; filter:grayscale(70%); }
   
      .btn<%=i%> {  }
      .btn<%=i%> li { position:absolute; bottom:20px; width:30px; height:30px; text-align:center; font-size:20px;
        font-weight:bold; line-height: 1.2;}
      .prev<%=i%> { left:20px; background:#fff; }
      .next<%=i%> { right:20px;background:#fff; }
   </style>
   
    <script src="http://code.jquery.com/jquery-latest.js"></script>
   <script>
   $(".prev<%=i%>").click(function(){
        $(".wrap<%=i%> li:last").prependTo(".wrap<%=i%>");
        $(".wrap<%=i%>").css({marginLeft:-650});
        $(".wrap<%=i%>").animate({marginLeft:0}, 650);
      });
      
      $(".next<%=i%>").click(function(){
       $(".wrap<%=i%>").animate({marginLeft:-650}, function(){
        $(".wrap<%=i%> li:first").appendTo(".wrap<%=i%>");
        $(".wrap<%=i%>").css({marginLeft:0});
      })
      });
      
   </script>
			<!-- 태그(for문으로 고쳐야됨:DB에 저장된 갯수만큼 나오기 위해서) -->
			<%=pBean.getTag()%>
			<!-- 여기까지 태그 -->
			<hr style="margin-bottom: 0px;">
			<!-- 댓글좋아요 갯수/댓글메인/댓글작성 -->
			<div class="footer">
				<div class="likecommentN">
					&nbsp;&nbsp;
					<%
					boolean flag = pMgr.likeCheck(id, pBean.getP_index());
					if(flag){ %>
					<button type="submit" onclick="javascript:like1('<%=pBean.getP_index()%>')">
						<img src="image/redheart20px.png">						
					</button>
					<%}else{ %>
					<button type="submit" onclick="javascript:like('<%=pBean.getP_index()%>')">
						<img src="image/blackheart20px.png">						
					</button>
					<%} %>
				</div>
				<hr style="margin: 5px;">
				<%
					Vector<CommentBean> cvlist = cMgr.selectComment(pBean.getP_index());
				%>
				<div class="commentmain">
					like <label><%=pMgr.likeInt(pBean.getP_index())%></label>&nbsp;&nbsp;comment <label><%=cMgr.commentInt(pBean.getP_index())%></label>
					<br style="margin: 5px;">
					<!-- 댓글부분 -->
					<%
						for (int j = 0; j < cvlist.size(); j++) {
								CommentBean cBean = cvlist.get(j);
								MemberBean cmBean = mMgr.getMember(cBean.getId());
								String cdate[] = cBean.getC_date().split("-");
					%>
					<div class="commentpeople">
						<img src="data/<%=cmBean.getProfile() + ".jpg"%>" />&nbsp;&nbsp;<label>
							<a href="mypage1.jsp?id=<%=cmBean.getId()%>"><%=cmBean.getId()%></a>
						</label> &nbsp;&nbsp;<label><%=cBean.getC_contents()%></label>
						&nbsp;&nbsp;&nbsp;<label id="commentDate"><%=cdate[0]%>/<%=cdate[1]%>/<%=cdate[2]%></label>
						<br style="margin: 4px;">
					</div>
					<%}%>
					<div class="commentN" style="border-bottom: 5px;"></div>
					<!-- 댓글부분 끝 -->
					<!-- 댓글 작성부분 시작 -->
					<form>
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								
 								<input type="text" class="form-control" style="margin-top: 10px;" placeholder="댓글 입력..." name = "commentWrite">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button" style="margin-top: 10px;" 
									onclick="writeCmt('<%=pBean.getP_index()%>',this.form.commentWrite.value)">입력</button>
								</span>
								
							</div>
						</div>
					</div>
					</form>
					<!-- 댓글 작성부분 끝 -->

				</div>
			</div>
		</div>
		<%}%>
	</div>
	<!-- 게시물 끝 부분 -->
	<!-- footer 시작 부분  -->
	<form name="cmtFrm" method="post" action="commentProc.jsp">
		<input type="hidden" name="p_index">
		<input type="hidden" name="comment">
	</form>
	<form name="likeFrm" method="get" action="likePlusProc.jsp">
		<input type="hidden" name="p_index">
	</form>
	<form name="like1Frm" method="get" action="likeMinusProc.jsp">
		<input type="hidden" name="p_index">
	</form>
	
<!--스크립트 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="script.js"></script>
<script>
function writePost() {
	document.postFrm.submit();
}
function writeCmt(p_index, comment){
	document.cmtFrm.p_index.value = p_index;
	document.cmtFrm.comment.value = comment;
	/* document.cmtFrm.comment.createElement('button'); */
	document.cmtFrm.submit();
}

function like(p_index){
	document.likeFrm.p_index.value = p_index;
	document.likeFrm.submit();
}
function like1(p_index){
	document.like1Frm.p_index.value = p_index;
	document.like1Frm.submit();
}

</script>



</body>

</html>