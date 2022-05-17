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

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	try {
		// form에서 전송받은 ID, Password와 DB의 ID, Password가 일치할 때 레코드 삭제(제거조건 : id 컬럼(Primary key))
		sql = "select id, pass from mbTbl where id = ?";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {	// ID가 존재할 때
			String rID = rs.getString("id");
			String rPassword = rs.getString("pass");
			
			// 패스워드가 일치하는지 확인. 첫번째 sql 변수값의 쿼리문에서 id를 조건으로 데이터를 조회하였기 때문에 ID는 이미 확인된 상황. 비밀번호만 일치하는지 확인하여도 무방함
			if (id.equals(rID) && passwd.equals(rPassword)) {	// 비밀번호까지 일치할 때
				sql = "delete mbTbl where id = ?";
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, id);
				
				pstmt.executeUpdate();
				
				out.println("해당 계정이 삭제되었습니다.");
				
			} else {	// 비밀번호가 일치하지 않을 때
				out.println("비밀번호가 일치하지 않습니다.");
			}
		} else {	// ID가 존재하지 않을 떄
			out.println("해당 계정은 존재하지 않습니다.");
		}
		
		out.println("<br/><br/>");
		out.println(sql);
		
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (rs != null) {
			rs.close();
		}
	}

%>
</body>
</html>