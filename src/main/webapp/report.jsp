<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>report</title>
  <link rel="stylesheet" href="style.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js"></script>
</head>
<body>

  <jsp:include page="header.jsp">
    <jsp:param name="title" value="report" />
  </jsp:include>

  <form action="report_week" method="post">
    <p>
      <input type="hidden" name="loginId_week" id="hiddenLoginid_week" value="${loginid_week}">
    </p>
    <p>
      <input type="submit" value="週生成" id="createBtn_week">
    </p>
  </form>

  <form action="report_month" method="post">
    <p>
      <input type="hidden" name="loginId_month" id="hiddenLoginid_month" value="${loginid_month}">
    </p>
    <p>
      <input type="submit" value="月生成" id="createBtn_month">
    </p>
  </form>

<<<<<<< HEAD
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
=======
  <%
    // サーブレットから受け取ったリストを取得
    List<String> details = (List<String>) request.getAttribute("detail_list");
    List<Integer> totals = (List<Integer>) request.getAttribute("totaltime_list");
>>>>>>> refs/remotes/origin/yasuda_servlet_test

    if (details == null) {
      details = new ArrayList<>();
    }
    if (totals == null) {
      totals = new ArrayList<>();
    }
  %>

  <div style="width: 600px; margin: 2em auto;">
    <canvas id="mychart-bar"></canvas>
  </div>

  <script>
    // JavaのリストをJavaScriptの配列へ変換
    const labels = [
      <% for (int i = 0; i < details.size(); i++) { %>
        "<%= details.get(i) %>"<%= (i < details.size() - 1) ? "," : "" %>
      <% } %>
    ];

    const data = [
      <% for (int i = 0; i < totals.size(); i++) { %>
        <%= totals.get(i) %><%= (i < totals.size() - 1) ? "," : "" %>
      <% } %>
    ];

    if (labels.length > 0 && data.length > 0) {
      const ctx = document.getElementById('mychart-bar').getContext('2d');
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: '作業時間（分）',
            data: data,
            backgroundColor: 'rgba(75, 192, 192, 0.7)'
          }]
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    }
  </script>

</body>
</html>
