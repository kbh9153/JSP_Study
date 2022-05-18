<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ include file="dbconn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./filegb.css" />
<title>Insert title here</title>
</head>
<body>
<%
	// DB에서 가져온 데이터를 저장하는 Vector 컬렉션 객체 생성
	Vector name = new Vector();
	Vector email = new Vector();
	Vector inputdate = new Vector();
	Vector subject = new Vector();
	Vector content = new Vector();
	
	// pagination 처리 변수 선언
	int where = 1;	// 현재 위치한 페이지
	int totalGroup = 0;	// 페이지그룹 총 개수
	int maxPage = 2;	// 화면에 출력할 페이지 개수
	int startPage = 1;	// 화면에 출력할 페이지의 첫번째 레코드
	int endPage = startPage + maxPage - 1;	// 화면에 출력할 페이지의 마지막 레코드
	int whereGroup = 1;	// 현재 위치한 페이지그룹
	
	// get 방식으로 페이지를 선택했을 때 go (현재페이지), gogroup(현재 페이지그룹) 변수를 받아서 처리
	if (request.getParameter("go") != null) {	// 현재 페이지 번호가 넘어올 때
		where = Integer.parseInt(request.getParameter("go"));
		whereGroup = (where - 1) / maxPage + 1;
		startPage = (whereGroup - 1) * maxPage + 1;
		endPage = startPage + maxPage - 1;
	} else if (request.getParameter("gogroup") != null) {	// 현재 페이지 그룹의 번호가 넘어올 때
		whereGroup = Integer.parseInt(request.getParameter("gogroup"));
		startPage = (whereGroup - 1) * maxPage + 1;
		where = startPage;
		endPage = startPage + maxPage - 1;
	}
	
	int nextGroup = whereGroup + 1;	// [다음] 버튼에 링크화 (pageGroup)
	int priorGroup = whereGroup - 1;	// [이전] 버튼에 링크화 (pageGroup)
	
	int nextPage = where + 1;	// 다음 페이지
	int priorPage = where - 1;	// 이전 페이지
	
	int startRow = 0;	// 특정 페이지의 시작 레코드 번호
	int endRow = 0;	// 특정 페이지의 마지막 레코드 번호
	int maxRows = 2;	// 출력시 2개의 레코드만 출력
	int totalRows = 0;
	int totalPages = 0;
	
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		sql = "select * from guestboard order by inputdate desc";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (!(rs.next())) {	// DB의 값이 존재하지 않을 때
			out.println("글이 존재하지 않습니다.");
		} else {	// DB에서 가져온 값을 출력
			do {	// DB에서 가져온 값을 Vector에 저장 후 원하는 페이지 번호의 값들을 Vector에서 추출하여 출력
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				inputdate.addElement(rs.getString("inputdate"));
				subject.addElement(rs.getString("subject"));
				content.addElement(rs.getString("content"));
			} while(rs.next());		// rs에 값이 존재하는 동안 계속 반복
			// 출력할 변수의 범위를 지정
			totalRows = name.size();	// Vector에 저장된 총 값
			totalPages = (totalRows - 1) / maxRows + 1;
			startRow = (where - 1) * maxRows;	// 특정 페이지에서 시작 row
			endRow = startRow + maxRows - 1;	// 특정 페이지에서 마지막 row
			
			if (endRow >= totalRows) {
				endRow = totalRows - 1;
			}
			
			totalGroup = (totalPages - 1) / maxPage + 1;	// totalGroup을 생성하는 수식
			
			if (endPage > totalPages) {
				endPage = totalPages;
			}
			
			// for문 시작
			for (int i = startRow; i <= endRow; i++) {
				// Vector에 저장된 값을 가져와서 출력
%>	
			<table class="show-table">
				<tr>
					<td colspan="2">
						<h2 class="show-table-h2"><%= subject.elementAt(i) %></h2>
					</td>
				</tr>
				<tr>
					<td>글쓴이 : <%= name.elementAt(i) %></td>
					<td>Email : <%= email.elementAt(i) %></td>
				</tr>
				<tr>
					<td colspan="2">작성일 : <%= inputdate.elementAt(i) %></td>
				</tr>
				<tr>
					<td colspan="2" class="show-table-td">내용 : <%= content.elementAt(i) %></td>
				</tr>
				<br />
				<tr>
					<td colspan="2"></td>
				</tr>
			</table>
<%
			}
			// for문 종료
			// out.println("startRow" + startRow + "<br/>");
			// out.println("emdRow" + endRow + "<br/>");
			
			// 페이징 출력 부분 처리
			if (whereGroup > 1) {
				out.println("[<a href=\"dbgb_show.jsp?go=1\"> 처음 </a>]");
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + priorGroup + "\"> 이전 </a>]");
			} else {
				out.println("[처음]");
				out.println("[이전]");
			}
			
			// 페이징 출력
			for (int i = startPage; i <= endPage; i++) {
				if (i == where) {
					out.println("[" + i + "]");
				} else {
					out.println("[<a href=\"dbgb_show.jsp?go=" + i + "\">" + i + "</a>]");
				}
			}
			
			if (whereGroup < totalGroup) {
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + nextGroup + "\"> 다음 </a>]");
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + totalGroup + "\"> 마지막 </a>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			
			out.println(where + "/" + totalPages);
		}
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (conn != null) {
			conn.close();
		}
		if (stmt != null) {
			stmt.close();
		}
	}
%>			
</body>
</html>