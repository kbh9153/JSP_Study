<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- c:forEach : 반복문 처리 -->
	<h3>구구단 출력</h3>
	<table>
		<c:forEach var="i" begin="1" end="30">
			<tr>
				<c:forEach var="j" begin="1" end="9">
					<td width=100>
						${i} * ${j} = ${i * j}
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</body>
</html>