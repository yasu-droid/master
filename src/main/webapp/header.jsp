<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
//リクエストの文字をUTF-8に編集
request.setCharacterEncoding("UTF-8");
// 各画面のタイトル名をパラメーターから取得
String title = request.getParameter("title");

//セッションにname（ログイン情報）があるとき、
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
    <!-- titleがセットされていればタイトル名、セットされていなければタイトル未設定 -->
	<p class="title"><%=title != null ? title : "タイトル未設定"%></p>
	<!-- アコーディオンメニュー -->
	<nav class="menu_outer">
		<div class="menu_index">
		　　<!-- 取得したnameを画面に表示 なければゲストを表示-->
			<%=name != null ? name : "ゲスト"%>
			<!-- nameを押したとき、アコーディオンを開閉する -->
			<div class="toggle_btn"></div>
		</div>
		<!-- アコーディオンを開いた時のメニュー -->
		<ul class="menu_container">
			<li>timer</li>
			<li>report</li>
			<li>logout</li>
		</ul>
	</nav>
	<script src="js/headerMenu.js" charset="utf-8"></script>
</body>

</html>
