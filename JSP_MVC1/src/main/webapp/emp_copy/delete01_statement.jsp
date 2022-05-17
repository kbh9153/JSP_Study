<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>
	
<form method="post" action="delete01_process.jsp">
	<p>사원번호 : <input type="number" name="eno" /></p>
	<p>사원명 : <input type="text" name="ename" /></p>
	<p>부서번호 : <input type="number" name="dno" /></p>
	<p><input type="submit" value="제출" /></p>
</form>
</body>
</html>