<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String number = request.getParameter("number");
%>

<!-- c:choose : 다중 조건문 처리 -->
<!-- c:when : c:choose 서브태그, 조건문이 참일 때 수행 -->
<!-- c:otherwise : c:choose 서브태그, 조건문이 거일 때 수행 -->

<!-- parameter를 받아오면 param.매개변수명 으로 작성할 것 -->
<!-- c:choose 구문 내 주석 금지. 에러발생함 -->
<c:choose>	
	<c:when test="${param.number % 2 == 0}">		
		<c:out value="${param.number}"></c:out> 은 짝수입니다.
	</c:when>
	<c:when test="${param.number % 2 == 1}">
		<c:out value="${param.number}"></c:out> 은 홀수입니다.
	</c:when>
	<c:otherwise>	
		숫자가 아닙니다.
	</c:otherwise>
</c:choose>
</body>
</html>

