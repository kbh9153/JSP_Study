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
	
	<p> 아이디 : <%= person.getId() %></p>
	<p> 이름 : <%= person.getName() %>
	
	<%
		// Setter 주입
		person.setId(20220530);
		person.setName("김유신");
	%>
	
	<p></p>
	
	<jsp:include page = "useBean03.jsp" />
</body>
</html>