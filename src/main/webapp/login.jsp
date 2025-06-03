0⃣<%@ page language="java" contentType="text/html; charset=UTF-8"
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
		<!-- 入力内容をpost送信 -->
		<form action="login" method="post">
			<p id="loginText">
			<!-- ログインIDの入力 -->
				<input type="text" id="loginID" name="loginID" placeholder="loginID" required>
				<br>
				<!-- パスワードの入力 -->
				<input type="password" id="loginPw" name="loginPw" placeholder="Password" required>
			</p>
			<p>
			<!-- 入力した内容を送信 -->
				<input type="submit" value="Log in" id="loginBtn">
			</p>
			<p>
			<!-- 新規会員の登録先 -->
				<a href="">新規会員登録</a>
			</p>
		</form>

		<%
		//ログインに関してのエラーメッセージをログインボックスの下に表示　エラーメッセージはservletから取得
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