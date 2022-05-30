<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="bean" class="dao.Calculator" />
	<!-- Calculator 클래스를 bean 객체로 사용 -->
	<!-- Calculator bean = new Calculator(); -->
	
	<%
		int m = bean.process(5);
		out.print("5의 3제곱은 : " + m);
	%>
	<p></p>
	5의 3 제곱은 : <%= m %>
</body>
</html>