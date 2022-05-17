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
	String dno = request.getParameter("dno");
	
	String sql = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	try {
		sql = "select * from emp_copy where eno = ?";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, eno);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			String pstmtEno = rs.getString("eno");
			if (eno.equals(pstmtEno)) {
				sql = "delete emp_copy where eno = ?"; 
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, eno);
				
				pstmt.executeUpdate();
				
				out.println(eno + " 사원의 정보가 삭제되었습니다.");
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
		if (pstmt != null) {
			pstmt.close();
		}
	}
%>
	
</body>
</html>