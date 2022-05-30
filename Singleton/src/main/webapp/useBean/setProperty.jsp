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
	
	<!-- setProperty : setter 주입 -->
	<jsp:setProperty property="id" name="person" value="20220601" />
		<!-- person 객체의 id를 setter를 통해서 접근 setId(20220601)) -->
	<jsp:setProperty property="name"  name="person" value="지방선거(휴일)" />
	
	<p> 아이디 : <%out.println(person.getId()); %></p>
	<p> 이름 : <%out.println(person.getName()); %></p>
	
	<p></p>
	<p></p>
	<p></p>
	
	<p> 아이디 : <%= person.getId() %>
	<p> 이름 : <%= person.getName() %>
</body>
</html>