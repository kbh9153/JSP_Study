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
<!-- 
	Statement
	 - 단일로 한번만 실행할 떄 적합함
	 - 쿼리에 인자를 부여할 수 없음 -> 변수를 쿼리에 적용할 '' 처리를 주의해야함
	 - 매번 컴파일을 수행해야함 -> cache(메모리)를 사용하지 않음
	 - 실행할 때 쿼리문을 메모리에 올려서 실행 -> ex. pstmt.executeQuery(sql);
	 
	PrepareStatement
	 - 쿼리에 인자를 부여할 수 있음. (?) 인자 처리가능 -> ? 인자에 변수를 할당함
	 - 처음 한번만 컴파일 진행한 후, 다시 컴파일을 수행하지 않음 -> cache(메모리)를 사용함
	 - 여러번 실행할 때 적합함
	 - 객체를 생성할 때 쿼리문을 넣음 -> ex. conn.prepareStatement(sql);
 -->

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
		PreparedStatement pstmt = null;		// SQL 쿼리를 담아서 실행하는 객체
		
		try {
			String sql = "SELECT * FROM mbTbl";	// ; 작성 X
			pstmt = conn.prepareStatement(sql);		// preparedstatement는 객체 생성할 때 sql 쿼리를 넣음	
			
			rs = pstmt.executeQuery();	// select한 결과를 ResultSet객체에 저장해야함. 이미 sql 쿼리가 pstmt에 들어가있기 때문에 executequery에 넣을 필요 없음 
			// pstmt.executeUpdate(sql)	: sql(INSERT, UPDATE, DELETE)문이 옴
			// pstmt.executeQuery(sql) : sql(SELECT)문이 오면서 결과를 RESULTSET 객체로 반환 
			
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
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	%>

</table>
</body>
</html>