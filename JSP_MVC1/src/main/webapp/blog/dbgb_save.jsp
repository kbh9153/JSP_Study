<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn_oracle.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert into Database</title>
</head>
<body>
<%
	// form 입력 데이터 get
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	
	// 내용 입력란 ' 입력 가능 처리
	int pos = 0;
	
	while((pos = content.indexOf("\'", pos)) != -1) {
		String left = content.substring(0, pos);
		String right = content.substring(pos, content.length());
		
		content = left + "\'" + right;
		pos += 2;
	}
	
	// 금일 날짜 처리
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = dateFormat.format(yymmdd);
	
	// Query
	String sql = null;
	PreparedStatement pstmt = null;
	
	int cnt = 0;
	
	try {
		sql = "insert into guestboard(name, email, inputdate, subject, content, password) values(?, ?, ?, ?, ?, ?)";
		pstmt.setString(1, "name");
		pstmt.setString(2, "email");
		pstmt.setString(3, ymd);
		pstmt.setString(4, "subject");
		pstmt.setString(5, "content");
		pstmt.setString(6, "password");
		
		pstmt = conn.prepareStatement(sql);
		cnt = pstmt.executeUpdate();
		
		if (cnt > 0) {
			out.print("정상적으로 입력되었습니다.");
		} else {
			out.print("입력을 실패하였습니다.");
		}
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
	}
%>

</body>
</html>