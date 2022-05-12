<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ include file="dbconn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="filegb.css" rel="stylesheet" type="text/css" />
<title>글 삭제(실제 DataBase에 삭제를 처리하는 페이지)</title>
</head>
<body>
	<a href="freeboard_list.jsp?go<%= request.getParameter("page") %>">게시판 목록으로 이동</a>
	
	<%
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;	// delete 정상 실행 여부 확인하는 변수
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		try {
			sql = "select * from freeboard where id = ?";	// DB의 id와 form으로 전송받은 id를 비교하여 확인 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if ( !(rs.next()) ) {
				out.print("해당 내용은 존재하지 않습니다.");
			} else {
				// id가 존재하는 경우에는 Password를 확인해보고 일치하면 삭제
				String pwd = rs.getString("password");
				
				if (pwd.equals(request.getParameter("password"))) {
					sql = "delete freeboard where id = ?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, id);
					
					cnt = pstmt.executeUpdate();
					
					if (cnt > 0) {
						out.println("해당 글은 삭제되었습니다.");
					} else {
						out.println("해당 내용은 삭제되지 않았습니다.");
					}
					
				} else {
					out.println("비밀번호가 일치하지 않습니다.");
				}
			}
		} catch (Exception e) {
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
</body>
</html>