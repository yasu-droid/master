<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.TimeOptions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>report</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js"
	integrity="sha512-VMsZqo0ar06BMtg0tPsdgRADvl0kDHpTbugCBBrL55KmucH6hP9zWdLIWY//OTfMnzz6xWQRxQqsUFefwHuHyg=="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@next/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
</head>
<body>

	<jsp:include page="header.jsp">
		<jsp:param name="title" value="timer" />
	</jsp:include>
	<div style="width: 400px">
		<canvas id="mychart-bar"></canvas>
	</div>
	<script>
		var ctx = document.getElementById('mychart-bar');
		var myChart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : [ 'Sun', 'Mon', 'Tue' ],
				datasets : [ {
					label : 'Red',
					data : [ 25, 35, 40 ],
					backgroundColor : '#f88',
				}, {
					label : 'Green',
					data : [ 20, 10, 30 ],
					backgroundColor : '#484',
				}, {
					label : 'Blue',
					data : [ 30, 20, 15 ],
					backgroundColor : '#48f',
				} ],
			},
		});
	</script>
	</div>
</body>
</html>