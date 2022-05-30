<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Bean의 Getter로 RAM의 값을 호출</title>
</head>
<body>
	<jsp:useBean id="person" class="dao.Person" scope="request" />
	<!-- scope="request" : bean을 사용하는 범위. 페이지, 세션 등 범위를 다양하게 지정 가능 -->
	
	<p> 아이디 : <%= person.getId() %></p>
	<p> 이름 : <%= person.getName() %></p>
</body>
</html>