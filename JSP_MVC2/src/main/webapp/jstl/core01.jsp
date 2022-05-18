<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL 사용 선언. JSTL 사용 조건 : 라이브러리.jar(WEB-INF/lib) 등록, 사용 선언 구문 작성 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    <!-- JSTL core 태그를 "c" 라는 이름으로 정의 -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	browser 변수 설정
	<c:set var="browser" value="${header['User-Agent']}"></c:set>  <!-- c:set : 변수 설정 -->
	<br/>
	<c:out value="${browser}"></c:out>	<!-- c:out : 출력 -->
	
	<p> browser 변수값 제거 후
		<c:remove var="browser"></c:remove>		<!-- c:remove : 변수 제거 -->
		<c:out value="${browser}"></c:out>
	</p>
</body>
</html>