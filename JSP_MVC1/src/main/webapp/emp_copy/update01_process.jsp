<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
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
	
	String sql = null;
	ResultSet rs = null;
	Statement stmt = null;
	
	try {
		sql = "select * from emp_copy where eno = '" + eno + "'";
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			String stmtEno = rs.getString("eno");
			if (eno.equals(stmtEno)) {
				sql = "update emp_copy set ename = '" + ename + "', " + "job = '" + job + "', " + "manager = '" + manager + "', " + "salary = '" + salary + "', " + "commission = '" + commission + "', " + "dno = '" + dno + "'"; 
				
				stmt = conn.createStatement();
				stmt.executeUpdate(sql);
				
				out.println(eno + " 사원의 정보가 수정되었습니다.");
			}
		} else {
			
		}
	} catch (Exception e) {
		out.println(eno + " 와 일치하는 사원이 없습니다.");
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
	}
%>
	
</body>
</html>