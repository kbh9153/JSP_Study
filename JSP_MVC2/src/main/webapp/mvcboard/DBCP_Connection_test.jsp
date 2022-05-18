<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="common.DBConnPool" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h3>DBCP Connection Test</h3>
	<% DBConnPool pool = new DBConnPool();	// 커넥션 객체 생성
	
		pool.close();	// 커넥션 객체 반납
	%>
</body>
</html>