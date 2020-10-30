<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		final String saveFolder = "C:/Jsp/myapp/WebContent/upload/filestorage";
	 	final String encoding  = "EUC-KR";
	 	final int maxSize = 10*1024*1024;//10mb 파일 용량 제한하는 부문
	 	//파일업로드 : 기본적 네트워크 or I/O
	 	try{
	 		//파일이 서버에 업로드 되는 시점
	 		MultipartRequest multi = 
	 		new MultipartRequest(request, saveFolder, maxSize, encoding,
	//DefaultFileRenamePolicy 중복이름을 가진 파일을 관리 해주는 매개변수이다. 
	 							new DefaultFileRenamePolicy());
	 		
	 		//요청한 form에 file type의 name값
	 		String fileName = multi.getFilesystemName("upload");
	 		
	 		//중복된 파일명이 변경되기 전에(오리지날) 업로드 파일명
	 		String original = multi.getOriginalFileName("upload");
	 		String type = multi.getContentType("upload");
	 		File f = multi.getFile("upload");
	 		long len = 0;
	 		if(f!=null){
	 			len = f.length();
	 		}

%>
저장된 파일 : <%=fileName %><br/>
실제 파일 : <%=original %><br/>
파일 타입 : <%=type %><br/>
파일 크기 : <%=len %><br/>
<%
	 	}catch(Exception e) {
	 		e.printStackTrace();
	 	}
 %>