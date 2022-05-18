<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update를 통한 데이터 수정</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>

<!-- 이름과 이메일을 업데이트 -->
<form method="post" action="update01_process.jsp">
	<p> 아이디 : <input type="text" name="id"> </p>	
	<p> 패스워드 : <input type="password" name="passwd"> </p>	
	<p> 이름 : <input type="text" name="name"> </p>	
	<p> 이메일 : <input type="text" name="email">	</p> 
	<p> <input type="submit" values="전송"> </p>
</form>
	
</body>
</html>