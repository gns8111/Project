<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>p.120 select</title>
</head>
<body>
<form method="get" action="P120">
 
    <!-- 직업을 물어보는 콤보박스 -->
    <span style="float: left; margin-right:20px;">
        <label for ="job">직업</label>
        <select id="job" name="job" size="1">
            <option value="">선택하세요</option>
            <option value="학생">학생</option>
            <option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
            <option value="언론">언론</option>
            <option value="공무원">공무원</option>
        </select>
    </span>
<!-- 관심분야를 물어보는 콤보박스 -->
    <label for ="interest" style="float:left">관심분야</label>
    <select id="interest" name="interest" size='5' multiple="multiple">
        <option value="에스프레소">에스프레소</option>
        <option value="카라멜마끼아로">카라멜마끼아로</option>
        <option value="카페모카">카페모카</option>
        <option value="아메리카노">아메리카노</option>        
    </select>
    <br/><br/>
    <input type="submit" value="전송" style="float:right; margin-right:50px;">
</form>
</body>
</html>

