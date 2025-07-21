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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.2.0/chart.min.js"></script>
</head>
<body>

	<jsp:include page="header.jsp">
		<jsp:param name="title" value="report" />
	</jsp:include>

	<form action="report_week" method="post">
		<p>
			<input type="hidden" name="loginId_week" id="hiddenLoginid_week"
				value="${loginid_week}">
		</p>
		<p>
			<input type="submit" value="週生成" id="createBtn_week">
		</p>
	</form>

	<form action="report_month" method="post">
		<p>
			<input type="hidden" name="loginId_month" id="hiddenLoginid_month"
				value="${loginid_month}">
		</p>
		<p>
			<input type="submit" value="月生成" id="createBtn_month">
		</p>
	</form>

	<%
	// サーブレットから受け取ったリストを取得
	List<String> details = (List<String>) request.getAttribute("detail_list");
	List<Integer> totals = (List<Integer>) request.getAttribute("totaltime_list");
	if (details == null) {
		details = new ArrayList<>();
	}
	if (totals == null) {
		totals = new ArrayList<>();
	}
	%>

<%
  List<String> detail_varChart_list = (List<String>) request.getAttribute("detail_varChart_list");
  List<Integer> week_totalTime_list = (List<Integer>) request.getAttribute("week_totalTime_list");
  List<String> week_log_date_list = (List<String>) request.getAttribute("week_log_date_list");

  List<String> dailyTasks = detail_varChart_list;
  List<Integer> dailyTimes = week_totalTime_list;
  List<String> dailyDates = week_log_date_list;

  List<String> colors = new ArrayList<>();
  if (dailyTasks != null) {
    for (int i = 0; i < dailyTasks.size(); i++) {
      colors.add(i % 2 == 0 ? "#FF6384" : "#36A2EB");
    }
  }
%>



	<div style="width: 600px; margin: 2em auto;">
		<canvas id="mychart-bar"></canvas>
	</div>

	<div style="width: 800px; margin: 3em auto;">
		<canvas id="dailyStackedChart"></canvas>
	</div>

	<script>
    // JavaのリストをJavaScriptの配列へ変換
    const labels = [
      <%for (int i = 0; i < details.size(); i++) {%>
        "<%=details.get(i)%>"<%=(i < details.size() - 1) ? "," : ""%>
      <%}%>
    ];

    const data = [
      <%for (int i = 0; i < totals.size(); i++) {%>
        <%=totals.get(i)%><%=(i < totals.size() - 1) ? "," : ""%>
      <%}%>
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

	<script>
  // JSPから受け取った配列をJSで扱う準備
  const dailyDates = [
    <%if (dailyDates != null) {
	for (int i = 0; i < dailyDates.size(); i++) {%>
        "<%=dailyDates.get(i)%>"<%=(i < dailyDates.size() - 1) ? "," : ""%>
    <%}
}%>
  ];

  const dailyTasks = [
    <%if (dailyTasks != null) {
	for (int i = 0; i < dailyTasks.size(); i++) {%>
        "<%=dailyTasks.get(i)%>"<%=(i < dailyTasks.size() - 1) ? "," : ""%>
    <%}
}%>
  ];

  const dailyTimes = [
    <%if (dailyTimes != null) {
	for (int i = 0; i < dailyTimes.size(); i++) {%>
        <%=dailyTimes.get(i)%><%=(i < dailyTimes.size() - 1) ? "," : ""%>
    <%}
}%>
  ];

  const colors = [
    <%for (int i = 0; i < colors.size(); i++) {%>
      "<%=colors.get(i)%>"<%=(i < colors.size() - 1) ? "," : ""%>
    <%}%>
  ];

  // 日付のユニークリスト
  const uniqueDates = [...new Set(dailyDates)];

  // 作業内容のユニークリスト
  const uniqueTasks = [...new Set(dailyTasks)];

  // 作業内容ごとに日付別データを準備
  const datasets = uniqueTasks.map((task, idx) => {
    const data = uniqueDates.map(date => {
      // その日・その作業の時間を取得（なければ0）
      let total = 0;
      dailyDates.forEach((d, i) => {
        if (d === date && dailyTasks[i] === task) {
          total += dailyTimes[i];
        }
      });
      return total;
    });
    // 色は単純にユニーク作業内容ごとに色割り当て（色リストのidxループ）
    return {
      label: task,
      data: data,
      backgroundColor: colors[idx % colors.length] || 'rgba(75, 192, 192, 0.7)'
    };
  });

  if (uniqueDates.length > 0 && datasets.length > 0) {
    const ctx = document.getElementById('dailyStackedChart').getContext('2d');
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: uniqueDates,
        datasets: datasets
      },
      options: {
        responsive: true,
        plugins: {
          title: {
            display: true,
            text: '日別・作業内容ごとの積み上げ棒グラフ'
          }
        },
        scales: {
          x: { stacked: true },
          y: { stacked: true, beginAtZero: true }
        }
      }
    });
  }
</script>

</body>
</html>
