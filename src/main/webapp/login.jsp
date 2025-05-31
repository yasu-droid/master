<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
<link rel="stylesheet" href="style.css">
</head>
<body class="login">
	<h1>ログインページ</h1>

	<div id="loginBox">
		<div id="loginTitle">Login</div>
		<form action="login" method="post">
			<p id="loginText">
				<input type="text" id="loginID" name="loginID" placeholder="loginID" required>
				<br>
				<input type="password" id="loginPw" name="loginPw" placeholder="Password" required>
			</p>
			<p>
				<input type="submit" value="Log in" id="loginBtn">
			</p>
			<p>
				<a href="">新規会員登録</a>
			</p>
		</form>

		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
		%>
			<p class="errorMes"><%=error %></p>
		<%
		}
		%>
	</div>
</body>
</html>