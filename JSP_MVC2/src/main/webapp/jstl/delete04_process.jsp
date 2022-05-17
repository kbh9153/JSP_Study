<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% request.setCharacterEncoding("utf-8"); %>      
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>

	<sql:setDataSource var="dataSource"
		url="jdbc:oracle:thin:@localhost:1521:xe"
		driver="oracle.jdbc.driver.OracleDriver"
		user="HR2" password="oracle" ></sql:setDataSource>
		
	<sql:update dataSource="${dataSource}" var="resultSet">
		delete member where id = ? and password = ?
		<sql:param value="<%= id %>">></sql:param>
		<sql:param value="<%= password %>">></sql:param>
	</sql:update>
	
	<c:import var="url" url="sql01.jsp"></c:import>
	${url}
</body>
</html>