<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="delete05_process.jsp">
		<p> 아이디 : <input type="text" name="id"> </p>	
		<p> 패스워드 : <input type="password" name="passwd"> </p>	
		<p> 이름 : <input type="text" name="name"> </p>	
		<p> 이메일 : <input type="text" name="email">	</p> 
		<p> <input type="submit" value="전송"> </p>
	</form>
</body>
</html>

<!-- 
	method="post"
	 -- http 헤더 앞에 값을 넣어 전송, 강력한 보안, 전송 용량의 제한이 없음 -> 파일 전송시 사용
	method="get"
	 -- http 헤더 뒤에 값을 붙여서 전송, 취약한 보안, 전송 용량의 제한이 있음
	 -- 게시판에서 사용
	
	submit을 클릭하면 form 양식에 입력된 데이터들을 가지고 action 페이지 호출
	-> action 페이지에서 전송받은 데이터를 DB에 저장
 -->