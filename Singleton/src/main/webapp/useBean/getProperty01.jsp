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
	<p> 아이디 : <jsp:getProperty property="id" name="person" />
		<!-- person 객체의 id 컬럼을 getter를 통해서 접근 (getId()) -->
	<jsp:getProperty name="person" property="id" />
		<!-- person 객체의 name을 getter를 통해서 접근 (getName()) -->
	<jsp:getProperty name="person" property="name" />
	
	<p></p>
	<p></p>
	<p></p>
	
	<p> 아이디 : <%= person.getId() %></p>
	<p> 이름 : <%= person.getName() %></p>
	
	<p></p>
	<p></p>
	<p></p>
	
	<p> 아이디 : <%out.println(person.getId()); %></p>
	<p> 이름 : <%out.println(person.getName()); %></p>
</body>
</html>