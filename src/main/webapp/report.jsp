<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>report</title>
<link rel="stylesheet" href="style.css">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js"></script>
</head>
<body>

	<jsp:include page="header.jsp">
		<jsp:param name="title" value="report" />
	</jsp:include>

	<form action="report" method="post">
		<p>
			<input type="hidden" name="loginId" id="hiddenLoginid"
				value="${loginid}">
		</p>
		<p>
			<!-- ログインIDを送信 -->
			<input type="submit" value="週生成" id="createBtn">
		</p>
	</form>


	<div style="width: 400px; margin: 0 auto;">
		<canvas id="mychart-bar"></canvas>
	</div>

	<!--
		<p>こんにちは、${loginid} さん</p>
	サーブレットから受け取る
	List<Integer> sumList = (List<Integer>) request.getAttribute("sum_list");
	if (sumList == null) { // ★ null セーフティ
		sumList = new ArrayList<>();
	}}
	%>
	-->

	<script src="script.js"></script>

</body>
</html>
