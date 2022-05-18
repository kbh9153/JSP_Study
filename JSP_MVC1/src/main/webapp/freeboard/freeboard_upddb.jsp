<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
request.setCharacterEncoding("euc-kr");
%>
<HTML>
<HEAD>
<TITLE>글 수정하기</TITLE>
</HEAD>
<BODY>
	<%@ include file="dbconn_oracle.jsp"%>
	[
	<a href="freeboard_list.jsp?go=<%=request.getParameter("page")%>">게시판 목록으로</a>]

	<%
	String sql = null;
	//Connection con = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	
	int cnt = 0;
	int pos = 0;
	
	String cont = request.getParameter("content");	// 글 내용

	if (cont.length() == 1) {	// 글 내용이 텍스트 1자라면
		cont = cont + " ";
	}
	
	// textarea 안에 ' 가 들어가면 DB에 Insert할 때 에러발생
	
	// ' 입력할 수 있도록 처리 -> Update, Insert 때 반드시 처리해줘야함
	while ((pos = cont.indexOf("\'", pos)) != -1) {	// -1 : 값이 존재하지 않을 때
		String left = cont.substring(0, pos);	// 컨텐츠 첫번째 텍스트 : ' 
		String right = cont.substring(pos, cont.length());	// 텍스트 전
		cont = left + "\'" + right;	// '\'텍스트 -> "'\'텍스트"
		pos += 2;
	}

	int id = Integer.parseInt(request.getParameter("id"));

	try {
		sql = "select * from freeboard where id = ?";
		
		st = conn.prepareStatement(sql);
		st.setInt(1, id);
		rs = st.executeQuery();
		
		if (!(rs.next())) {
			out.println("해당 내용이 없습니다");
		} else {
			String pwd = rs.getString("password");
			
			if (pwd.equals(request.getParameter("password"))) {
				sql = "update freeboard set name= ?, email=?,";
				sql = sql + "subject=?,content=? where id=? ";
				
				st = conn.prepareStatement(sql);
				
				st.setString(1, request.getParameter("name"));
				st.setString(2, request.getParameter("email"));
				st.setString(3, request.getParameter("subject"));
				st.setString(4, cont);
				st.setInt(5, id);
				
				cnt = st.executeUpdate();
				
				if (cnt > 0) {
					out.println("정상적으로 수정되었습니다.");
				} else {
					out.println("수정되지 않았습니다.");
				}
			} else {
				out.println("비밀번호가 틀립니다.");
			}
		}
	} catch (SQLException e) {
		out.println(e);
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (st != null) {
			st.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	%>
</BODY>
</HTML>
