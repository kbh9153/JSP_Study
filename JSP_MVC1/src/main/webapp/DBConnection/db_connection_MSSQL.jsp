<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>	<% // 자바의 라이브러리 import %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MSSQL DB Connection</title>
</head>
<body>
	<%
		 //변수 초기화
		 Connection conn = null;   // DB를 연결하는 객체
		 String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";   // MSSQL Driver에 접속
		 String url = "jdbc:sqlserver://localhost:1433;DatabaseName=myDB";// 포트;DB명
		 Boolean connect = false;  // 접속이 잘되는지 확인 하는 변수
		 
		 try {
		    Class.forName(driver);  // MSSQL 드라이버 로드
		    conn = DriverManager.getConnection(url,"sa","1234");  // url주소, 계정, 비밀번호
		     
		    connect = true;
		    conn.close();
		 } catch (Exception e) {
		    connect = false;
		    e.printStackTrace();
		 }

	%>
	
	<%
		if (connect == true) {
			out.println("MSSQL DB에 정상적으로 접속되었습니다.");
		} else {
			out.println("MSSQL DB 연결에 실패하였습니다.");
		}
	%>
</body>
</html>