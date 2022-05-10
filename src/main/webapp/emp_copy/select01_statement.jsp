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

<table width="700" border="1">
	<tr>
		<th>사원번호</th>
		<th>사원명</th>
		<th>직무</th>
		<th>직속상사</th>
		<th>입사일</th>
		<th>급여</th>
		<th>상여금</th>
		<th>부서번호</th>
	<tr/>
	
	<%
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			String sql = "SELECT * FROM EMP_COPY";
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String eno = rs.getString("eno");
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				String manager = rs.getString("manager");
				String hiredate = rs.getString("hiredate");
				String salary = rs.getString("salary");
				String commission = rs.getString("commission");
				String dno = rs.getString("dno");
			
			%>
			<tr>
				<td><%= eno %></td>
				<td><%= ename %></td>
				<td><%= job %></td>
				<td><%= manager %></td>
				<td><%= hiredate %></td>
				<td><%= salary %></td>
				<td><%= commission %></td>
				<td><%= dno %></td>
			<tr/>
			
		<%
			}
		} catch (Exception e) {
			out.println("테이블 호출 실패");
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
</table>
</body>
</html>