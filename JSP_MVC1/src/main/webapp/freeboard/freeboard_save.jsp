<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%@ include file = "dbconn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form의 값을 받아서 DataBase에 값을 넣어주는 파일</title>
</head>
<body>
<%
	// form에서 전송받은 파라미터를 변수에 저장
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id = 1;	// DB에 id컬럼에 저장할 값
	int pos = 0;
	
	if (cont.length() == 1) {
		cont = cont + " ";
	}
	
	// DB에 저장할 때 content(textarea)에 엔터를 처리해줘야함
	while ((pos = cont.indexOf("\'", pos)) != -1) {
		String left = cont.substring(0, pos);
		String right = cont.substring(pos, cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}
	
	// 오늘의 날짜 처리
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	Statement stmt = null;	// 쿼리문을 실행하기 위한 객체
	ResultSet rs = null;
	int cnt = 0;	// Insert가 성공여부 확인하는 변수
	
	try {
		// 값을 저장하기 전에 최신 글번호(max(id))를 가져와서 + 1을 적용
		// conn (Connection) : Auto Commit;이 작동됨 -> commit을 명시하지 않아도 insert, update, delete 구문은 자동 커밋됨
		stmt = conn.createStatement();
		sql = "select max(id) from freeboard";
		
		rs = stmt.executeQuery(sql);
		
		if (!rs.next()) {	// rs의 값이 존재하지 않을 때
			id = 1;
		} else {	// rs의 값이 존재할 때
			id = rs.getInt(1) + 1;	// getInt(1) : 1번째 컬럼의 최대값에 + 1
		}
		
		sql = "INSERT INTO freeboard (id, name, password, email, subject,";   
        sql = sql + "content, inputdate, masterid, readcount, replynum, step)";
        sql = sql + " VALUES (" + id + ", '" + na + "', '" + pw + "', '" + em + "', ";
        sql = sql + "'" + sub + "', '" + cont + "', '" + ymd + "', " + id + ", ";
        sql = sql + "0, 0, 0)";
		
		// out.println(sql);
		cnt = stmt.executeUpdate(sql);	// cnt > 0 : Insert 성공
				// executeUpdate의 기능은 2가지
				// 1. 쿼리문 실행, 2. select, update, delete가 정상적으로 실행된 건수를 반환

		if (cnt > 0) {
			out.println("데이터가 성공적으로 입력되었습니다.");
		} else {
			out.println("데이터 입력이 실패하였습니다.");
		}
		
		out.println("<br/><br/>");
		out.println(sql);
	} catch (Exception e) {
		
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
	}
%>

<!-- 글이 다 입력되면 해당 데이터를 freeboard_list.jsp로 전송 -->
<jsp:forward page = "freeboard_list.jsp"></jsp:forward>

<!-- 
	페이지 이동
	
	jsp:forward	: 서버단에서 페이지를 이동(서버 -> 서버), 클라이언트의 기존 URL 정보가 변경되지 않음
	response.sendRedirect : 클라이언트의 페이지 재요청으로 페이지 이동, 이동하는 페이지로 URL 정보가 변경됨
 -->
</body>
</html>