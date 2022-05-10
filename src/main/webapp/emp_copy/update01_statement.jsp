<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "dbconn_oracle.jsp" %>
	
<form method="post" action="update01_process.jsp">
	<p>사원번호 : <input type="number" name="eno" /></p>
	<p>사원명 : <input type="text" name="ename" /></p>
	<p>직무 : <input type="text" name="job" /></p>
	<p>직속상사번호 : <input type="number" name="manager" /></p>
	<p>입사일 : <input type="date" name="hiredate" /></p>
	<p>급여 : <input type="number" name="salary" /></p>
	<p>상여금 : <input type="number" name="commission" /></p>
	<p>부서번호 : <input type="number" name="dno" /></p>
	<p><input type="submit" value="제출" /></p>
</form>
</body>
</html>