<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
request.setCharacterEncoding("UTF-8");

// タイトル取得
String title = request.getParameter("title");

// セッション取得
String name = null;
if (session != null) {
	name = (String) session.getAttribute("name");
}
%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<p class="title"><%=title != null ? title : "タイトル未設定"%></p>
	<nav class="menu_outer">
		<div class="menu_index">
			<%=name != null ? name : "ゲスト"%>
			<div class="toggle_btn"></div>
		</div>
		<ul class="menu_container">
			<li>timer</li>
			<li>report</li>
			<li>logout</li>
		</ul>
	</nav>
	<script src="js/headerMenu.js" charset="utf-8"></script>
</body>

</html>
