<%@page import="com.mysql.cj.protocol.Resultset"%>
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
	request.setCharacterEncoding("UTF-8");	// 데이터의 한글 처리
	
	// request 객체의 getParameter로 form에서 전송받은 값을 변수값으로 할당
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null;
	ResultSet rs = null;	// select한 결과를 담은 객체, Select한 레코드셋을 담고 있음
	String sql = null;
	
	// form에서 전송받은 ID와 Password를 DB에서 가져온 ID, Password를 비교해서 같으면 Update 실행, 다르면 Update 실행불가
	try {
		// form에서 전송받은 ID를 조건으로 DB의 값을 select
		sql = "SELECT ID, PASS FROM mbTbl WHERE id = '" + id + "'";
		stmt = conn.createStatement();	// conn의 createStatement()를 사용해서 stmt 객체를 활성화
		
		rs = stmt.executeQuery(sql);
		// stmt.executeUpdate(sql)	: INSERT, UPDATE, DELETE
		// stmt.executeQuery(sql) : SELECT문이 오면서 결과를 RESULTSET 객체로 반환 
		
		if (rs.next()) {	// DB에 form에서 전송받은 ID가 존재하면 -> form에서 넘긴 패스워드와 DB의 Password가 일치하는지 확인
			// out.println(id + " : 해당 아이디가 존재합니다.");
		
			// DB에서 가져온 ID와 Password를 변수에 할당
			String rID = rs.getString("id");
			String rPassword = rs.getString("pass");
			
			// form에서 넘겨준 값과 DB에서 가져온 값이 일치하는지 확인
			if (id.equals(rID) && passwd.equals(rPassword)) {	// 패스워드가 일치할 떄
				// DB에서 가져온 Password와 form에서 전송받은 패스워드가 일치할 때 Update 실행
				// sql 변수 재사용하여 Update
				sql = "UPDATE mbTbl SET NAME = '" + name + "', EMAIL = '" + email + "' WHERE ID = '" + id + "'";
				
				out.println("정보가 수정되었습니다.");
				
				stmt = conn.createStatement();
				stmt.executeUpdate(sql);
			} else {	// 패스워드가 일치하지 않을 때
				out.println("패스워드가 일치하지 않습니다.");
			}
		} else {	// DB에 form에서 전송받은 ID가 존재하지 않으면
			out.println(id + " : 해당 ID가 데이터베이스에 존재하지 않습니다.");
		}
		
		out.println("<br/><br/>");
		out.println(sql);
	} catch (Exception e) {
		out.println(e.getMessage());
		out.println(sql);
	} finally {
		if (rs != null) {
			rs.close();
		}
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