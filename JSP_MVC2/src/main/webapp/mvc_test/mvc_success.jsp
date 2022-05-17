<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.model.LoginBean" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login 성공 페이지</title>
</head>
<body>
	<p>로그인을 성공하였습니다.</p>
	<p>
		<%
			LoginBean bean = (LoginBean) request.getAttribute("bean");	// request.setAttribute("bean", bean)에서 전송받은 데이터를 get
			out.println("아이디 : " + bean.getId());
		%>
	</p>
</body>
</html>