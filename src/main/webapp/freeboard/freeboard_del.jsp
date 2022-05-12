<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="freeboard.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function check() {
		with(document.msgdel) {
			if (password.value.length == 0) {
			alert("비밀번호를 입력해주세요");
			password.focus();
			return false;
		}
		document.msgdel.submit();
	}
}
</script>

<title>글 삭제 페이지</title>
</head>
<body>
	삭제 페이지입니다.
	<main>
		<form name="msgdel" method="post" action="freeboard_deldb.jsp">
			<!-- HTML 페이지에 출력은 하지 않으나 변수의 값을 다른 페이지로 넘길 때 id 변수와 page 변수의 값을 처리 -->
			<input type="hidden" name="id" value="<%= request.getParameter("id") %>" />
			<input type="hidden" name="page" value="<%= request.getParameter("page") %>" />
			
			<table width="70%" cellspacing="0" cellpadding="2">
				<tr>
					<td colspan="2" bgcolor="#1f4f8f" height="1"></td>
				</tr>
				<tr>
					<td class="notice" colspan="2" bgcolor="#DFEDFF" height="20">
						<b>글 삭제하기</b>
					</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td class="input_style1" width="124" height="30" bgcolor="#f4f4f4" align="center">
						비밀번호
					</td>
					<td width="494">
						<input class="input_style1" type="password" name="password">
					</td>
				</tr>
				<tr>
					<td class="button" colspan="2" height="1"></td>
				</tr>			
				<tr>
					<td colspan="2" height="1" bgcolor="#1F4F8F"></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#1F4F8F"></td>
				</tr>
				<tr>
					<td colspan="2" height="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<table width="100%" border="0" cellpadding="4" cellspacing="4">
							<tr>
								<td width="84%">&nbsp;</td>
								<td width="8%">
									<a href="freeboard_list.jsp?go=<%= request.getParameter("page") %>">
										<img src="image/list.jpg" width="48" height="19" border="0" />
									</a>
								</td>
								<td width="8%">
									<a href="#" onClick="check()" >
										<img src="image/del.jpg" width="46" height="19" border="0" />
									</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</main>
</body>
</html>