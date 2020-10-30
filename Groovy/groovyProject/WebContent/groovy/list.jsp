<!-- list.jsp -->
<%@page import="com.groovy.dao.UtilMgr"%>
<%@page import="com.groovy.dto.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="com.groovy.dao.BoardMgr"/>
<jsp:useBean id="cmgr" class = "com.groovy.dao.BCommentMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalRecord = 0;//총 게시물 수
		int numPerPage = 10;//페이징 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지 디폴트
		int nowBlock = 1;//현재 블럭 디폴트
		
		//page에 보여 줄 게시물 개수 값
		if(request.getParameter("numPerPage")!=null&&
				!request.getParameter("numPerPage").equals("null")){
			numPerPage = UtilMgr.parseInt(request, "numPerPage");
		}
		
		
		int start = 0;//테이블에 시작 번호
		int cnt = numPerPage;//10개냐 5개냐 15개냐 30개냐 가능하니깐
		
		//검색에 필요한 변수들
		String keyField = "", keyWord = "";
		//검색일 때는
		if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
		}
		//검색 후에 다시 처음화면으로 요청
		if(request.getParameter("reload")!=null&&request.getParameter("reload").equals("true")){
			keyField = ""; keyWord = "";
			
		}
		
		
		totalRecord = mgr.getTotalCount(keyField, keyWord);
		//out.print(totalRecord);
		
		//nowPage를 요청한 경우
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		//테이블 시작번호
		start = (nowPage*numPerPage)-numPerPage;
		
		//전체 페이지 수(전체 레코드 수/페이지당 레코드 수) 올림.
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		
		//전체 블럭 수(전체 페이지 수/블럭당 페이지 수) 올림.
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		
		//현재 블럭(현재 페이지 수/블럭당 페이지 수)올림.
		//현재 블럭값이 있어야 전 후 버튼을 표현할 수 있다.
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>
<html>
<head>
	<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.submit();
	}
	
	function block(block) {
		document.readFrm.nowPage.value = 
			<%=pagePerBlock%>*(block-1)+1;
			document.readFrm.submit();	
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();	
	}
</script>
</head>
<body bgcolor="#FFFFCC" >
<div align="center"><br/>
<h2>JSP Board</h2><br/>
<table>
	<tr>
		<td width = "600">
		Total : <%=totalRecord %>Articles
		(<font color = "red"><%=nowPage + "/" + totalPage %>Pages
		</font>)
		</td>
		<td align = "right">
			<form name="npFrm" method="post">
					<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)">
    					<option value="5">5개 보기</option>
    					<option value="10" selected>10개 보기</option>
    					<option value="15">15개 보기</option>
    					<option value="30">30개 보기</option>
   				</select>
   			</form>
   			<script>document.npFrm.numPerPage.value="<%=numPerPage%>"</script>
   		</td>
	</tr>
</table>
<table>
	<tr>
		<td align="center" colspan="2">
		<%
			Vector<BoardBean> vlist = mgr.getBoardList(keyField, keyWord, start, cnt);
			int listSize = vlist.size();//브라우저 화면에 표시 될 게시물 번호 값이다.
			if(vlist.isEmpty()){
				out.println("등록된 게시물이 없습니다.");
			}else{
		%>	
		<table cellspacing="0">
			<tr align="center" bgcolor="#D0D0D0">
				<td width="100">번 호</td>
				<td width="250">제 목</td>
				<td width="100">이 름</td>
				<td width="150">날 짜</td>
				<td width="100">조회수</td>
			</tr>
		<%
			for(int i = 0; i<numPerPage;i++){
				if(i==listSize) break;//제일 마지막 페이지가 10이 아닌 경우
				BoardBean bean = vlist.get(i);
				int num = bean.getNum();
				String subject = bean.getSubject();
				String name = bean.getName();
				String regdate = bean.getRegdate();
				int depth = bean.getDepth();//답변의 길이
				int count = bean.getCount();//조회수
				String filename = bean.getFilename();//첨부파일
				
				//댓글 count
				int bcount = cmgr.getBCommentCount(num);
		%>
			<tr align = "center">
				<td><%=totalRecord-start-i%></td>
				<td align = "left">
				<%
					for(int j = 0; j<depth;j++){
						out.println("&nbsp;&nbsp;");
					}
				 %>
				<a href = "javascript:read('<%=num%>')"><%=subject%></a>
				<%if(filename!=null&&!filename.equals("")){ %>
					<img src="img/icon_file.gif" align ="middle">
				<%} %>
				<%if(bcount>0) { %>
					<font color = "red">(<%=bcount %>)</font>
				<%} %>
				</td>
				<td><%=name%></td>
				<td><%=regdate%></td>
				<td><%=count%></td>
			</tr>
			<%}//-------------for%>
		</table>
		<%}//-----if %>
		</td>
	</tr>
<tr>
	<td colspan = "2"><br/><br/></td>
</tr>
<tr>
	<td>
				<%if(totalPage>0){ %>
				<!-- 이전 블럭 -->
				<%if(nowBlock>1) {%>
					<a href = "javascript:block('<%=nowBlock-1%>')">prev...</a>
				<%} %>
				<!-- 페이징 -->
				<%
						int pageStart = (nowBlock-1)*pagePerBlock+1;
						int pageEnd = (pageStart+pagePerBlock)<totalPage?
								pageStart+pagePerBlock:totalPage+1;
						for(;pageStart<pageEnd;pageStart++){
				%>
					<a href = "javascript:pageing('<%=pageStart%>')">
					<%if(pageStart==nowPage){ %><font color = "red"><%} %>
					[<%=pageStart %>]
					<%if(pageStart==nowPage){ %></font><%} %>
					<%} %>
					</a>
					<% }//-----------for%>
				
				<!-- 다음 블럭 -->
					<%if(totalBlock>nowBlock) {%>
					<a href = "javascript:block('<%=nowBlock+1%>')">....next</a>
			<%} %>
	<td align = "right">
		<a href = "post.jsp">[글쓰기]</a>
		<a href = "javascript">[처음으로]</a>
	 </td>
</tr>

</table>

<hr width = "750%">

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="name"> 이 름</option>
    				<option value="subject"> 제 목</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
</form>

<form name="readFrm">
	<input type="hidden" name="num">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
</form>

</div>
</body>
</html>
