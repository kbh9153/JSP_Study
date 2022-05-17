<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼에서 전송받은 값을 DB에 저장하는 파일</title>
</head>
<body>
<%@ include file="dbconn_oracle.jsp" %>
<% // dbconn_oracle.jsp의 코드가 들어와있음 %> 

<%
	request.setCharacterEncoding("UTF-8");	// 폼에서 넘긴 한글처리 목적
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null;	// Statement 객체 : SQL 쿼리 구문을 담아서 실행하는 객체
	String sql = null;
	
	try {
		sql = "INSERT INTO mbTbl(idx, id, pass, name, email) VALUES(seq_mbTbl_idx.nextval, '" + id + "', '" + passwd + "', '" + name + "', '" + email + "')";
		// 객체값에서 DB 데이터 자료형이 아니라 객체 타입에 알맞게 확인 후 '' 붙여줄 것(ex. 'passwd' -> 객체 타입 String)
		
		stmt = conn.createStatement();	// connection 객체를 통해서 statement 객체 생성
										// connection 객체는 include 된 dbconn_oracle.jsp 파일에 있음
		stmt.executeUpdate(sql);		// statement 객체를 통해서 sql 변수을 실행		
		// stmt.executeUpdate(sql)	: sql(INSERT, UPDATE, DELETE)문이 옴
		// stmt.executeQuery(sql) : sql(SELECT)문이 오면서 결과를 RESULTSET 객체로 반환 
		
		out.println("테이블 삽입에 성공 했습니다.");
		// out.println(sql);
		
	} catch (Exception e) {
		out.println("mbTbl 테이블 삽입을 실패하였습니다.");	// jsp에선 System.out.println에서 System이 제외
		out.println(e.getMessage());
		out.println("<br>");	// JSP 구문 안에서 HTML 사용
		// out.println(sql);
	} finally {
		if (stmt != null) {
			stmt.close();
		}
		
		if (conn != null) {
			conn.close();
		}
	}
%>

<br/><br/>
<%= id %> <br/>	<% // %= : 스크린 출력 %>
<%= passwd %> <br/>
<%= name %> <br/>

<%= sql %> <br/>
<% out.println(sql); %>

</body>
</html>