<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Java Bean 사용</title>
</head>
<body>
	<jsp:useBean id="date" class="java.util.Date" />
	<!-- Java Bean은 JSP 페이지에서 확장자가 *.java 페이지에게 로직을 처리하도록 JSP 페이지에서 셋팅 -->
	<p>
		<%
			out.println("오늘의 날짜 및 시간");
		%>
	</p>
	<%=date%>
	
</body>
</html>