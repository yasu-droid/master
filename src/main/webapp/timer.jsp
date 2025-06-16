<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.TimeOptions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タイマー</title>
<link rel="stylesheet" href="style.css">
<script src="js/countdown_time.js"></script>
</head>

<body class="timerBox">

	<jsp:include page="header.jsp">
		<jsp:param name="title" value="timer" />
	</jsp:include>
	<!-- HTMLコメント -->
	<!--  <h2>タイマー1</h2> -->

	<form>
		<div class="timer">
			<label for="minutes">作業時間:</label> <select id="minutes">
				<%
				List<Integer> options = TimeOptions.getMinuteOptions();
				for (int m : options) {
				%>
				<option value="<%=m%>"><%=m%>分
				</option>
				<%
				}
				%>
			</select> <input type="text" name="details" id="details" placeholder="作業内容を入力">
		</div>

		<div>
			<button class="startBtn" type="button" id="startBtn"
				onclick="startTimer()">スタート</button>
		</div>
	</form>
	<h3 id="timer">00:00</h3>

	<%-- forループのテスト(JSPコメント) --%>

</body>
</html>
