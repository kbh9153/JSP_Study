<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>
	
<%
	request.setCharacterEncoding("UTF-8");

	String eno = request.getParameter("eno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	Statement stmt = null;
	
	try {
		String sql = "INSERT INTO EMP_COPY (eno, ename, job, manager, hiredate, salary, commission, dno) VALUES ('" + eno  + "', '" + ename + "', '" + job + "', '" + manager + "', '" + hiredate + "', '" + salary + "', '" + commission + "', '" + dno + "')"; 
		stmt = conn.createStatement();
		
		stmt.executeUpdate(sql);
		
		out.println("입력완료");
	} catch (Exception e) {
		out.println("입력실패");
		out.println(e.getStackTrace());
	} finally {
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	
%>	
</body>
</html>