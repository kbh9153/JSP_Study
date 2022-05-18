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
		String name = request.getParameter("name");
	%>
	
	<sql:setDataSource var="dataSource"
		url="jdbc:oracle:thin:@localhost:1521:xe"
		driver="oracle.jdbc.driver.OracleDriver"
		user="HR2" password="oracle" ></sql:setDataSource>
		
	<!-- preparestatement와 같이 ?에 해당하는 컬럼을 명시해줘야 함 -->
	<!-- sql:param : preparestatement 역할과 같이 ? 해당하는 컬럼 명시 -->
	<!-- sql:update 내부에 주석 금지. 에러 발생함 -->
	<sql:update dataSource="${dataSource}" var="resultSet">
		insert into member(id, password, name) values(?, ?, ?)	
		<sql:param value="<%= id %>"></sql:param>	
		<sql:param value="<%= password %>"></sql:param>
		<sql:param value="<%= name %>"></sql:param>
	</sql:update>
	
	<c:import var="url" url="sql01.jsp"></c:import>
	
	${url}
</body>
</html>