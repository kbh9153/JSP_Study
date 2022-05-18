<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- c:if : 조건문 처리. choose는 다중 조건, if는 단일 조건 -->

	<!-- JSTL로 DataBase Connection 설정 -->
	<sql:setDataSource var="dataSource"
		url="jdbc:oracle:thin:@localhost:1521:xe"
		driver="oracle.jdbc.driver.OracleDriver"
		user="HR2" password="oracle" ></sql:setDataSource>
	
	<sql:query var="resultSet" dataSource="${dataSource }">
		select * from member
	</sql:query>
	
	<table border="1">
		<tr>
			<c:forEach var="columnName" items="${resultSet.columnNames}">
				<th width="100">
					<c:out value="${columnName}"></c:out>
				</th>
			</c:forEach>
		</tr>
		
		<c:forEach var="row" items="${resultSet.rowsByIndex}">
			<tr>
				<c:forEach var="column" items="${row}" varStatus="i">
					<td>
						<c:if test="${column != null}">
							<c:out value="${column }"></c:out>
						</c:if>
						<c:if test="${column == null }">
							$nbsp;
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</body>
</html>