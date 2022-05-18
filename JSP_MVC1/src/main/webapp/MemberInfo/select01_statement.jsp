<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력하기</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp"%>

<table width="500" border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>email</th>
		<th>city</th>
		<th>phone</th>
	<tr/>
	
	<%
		ResultSet rs = null;	// ResultSet 객체는 DB의 테이블을 Select에서 나온 결과(레코드셋)를 담은 객체
		Statement stmt = null;	// SQL 쿼리를 담아서 실행하는 객체
		
		try {
			String sql = "SELECT * FROM mbTbl";	// ; 작성 X
			stmt = conn.createStatement();	// connection 객체의 createStatement()로 stmt를 활성화
			
			rs = stmt.executeQuery(sql);	// select한 결과를 ResultSet객체에 저장해야함
			// stmt.executeUpdate(sql)	: sql(INSERT, UPDATE, DELETE)문이 옴
			// stmt.executeQuery(sql) : sql(SELECT)문이 오면서 결과를 RESULTSET 객체로 반환 
			
			while (rs.next()) {	// DB row 수만큼 반복하여 변수값으로 할당하여 HTML을 통하여 출력
				String id = rs.getString("id");	
				String pw = rs.getString("pass");	// select 결과이기 때문에 DB 컬럼명과 동일하게 작성. form의 name 속성값이 아님. 데이터를 받아오는 곳이 어딘지 고려하여 작성할 것
				String name = rs.getString("name");
				String email = rs.getString("email");
				String city = rs.getString("city");
				String phone = rs.getString("phone");
			%>	
				<tr>
					<td><%= id %></td>
					<td><%= pw %></td>
					<td><%= name %></td>
					<td><%= email %></td>
					<td><%= city %></td>
					<td><%= phone %></td>
				<tr/>
		<% 		
			}
		} catch(Exception e) {
			out.println("테이블 호출을 실패하였습니다.");
			out.println(e.getMessage());
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

</table>
</body>
</html>