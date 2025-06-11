<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>report</title>
  <link rel="stylesheet" href="style.css">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js"></script>
</head>
<body>

<jsp:include page="header.jsp">
  <jsp:param name="title" value="report" />
</jsp:include>

<div style="width:400px;margin:0 auto;">
  <canvas id="mychart-bar"></canvas>
</div>

<%
  // サーブレットから受け取る
  List<Integer> sumList = (List<Integer>) request.getAttribute("sum_list");
  if (sumList == null) {     // ★ null セーフティ
      sumList = new ArrayList<>();
  }
%>

<script>
  // サーブレットが渡した配列を JS 配列に
  const data = [<% for (int i = 0; i < sumList.size(); i++) { %>
      <%= sumList.get(i) %><%= (i < sumList.size()-1) ? "," : "" %>
  <% } %>];

  const ctx = document.getElementById('mychart-bar').getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: data.map((_, i) => `作業${i + 1}`),
      datasets: [{
        label: '作業時間（分）',
        data: data,
        backgroundColor: 'rgba(75, 192, 192, 0.6)'
      }]
    },
    options: { scales: { y: { beginAtZero: true } } }
  });
</script>

</body>
</html>
