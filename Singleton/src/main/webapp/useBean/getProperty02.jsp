<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="person" class="dao.Person" scope="request" />
	<jsp:setProperty name="person" property="id" value="20220606" />
	<jsp:setProperty name="person" property="id" value="현충일(휴일)" />
	
	<p> 아이디 : <jsp:getProperty name="person" property="id" />
	<p> 이름 : <jsp:getProperty name="person" property="name" />
</body>
</html>