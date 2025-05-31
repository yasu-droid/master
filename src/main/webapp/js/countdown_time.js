function startTimer() {
  const select = document.getElementById("minutes");
  let seconds = parseInt(select.value) * 60;
  const display = document.getElementById("timer");
  const btn = document.getElementById("startBtn");
  btn.disabled = true;

  const startTimestamp = new Date(); // 開始時刻

  const interval = setInterval(() => {
    if (seconds <= 0) {
      clearInterval(interval);
      const endTimestamp = new Date(); // 終了時刻
      display.innerText = "お疲れ様でした";
      btn.disabled = false;

      // 終了後に fetch で JSP に送信
      fetch("logTimer.jsp", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body:
          "duration=" + encodeURIComponent(select.value) +
          "&start=" + encodeURIComponent(startTimestamp.toISOString()) +
          "&end=" + encodeURIComponent(endTimestamp.toISOString()) +
          "&details=" + encodeURIComponent(document.getElementById("details").value)
      })
      .then(response => response.text())
      .then(data => {
        console.log("サーバー応答:", data);
      })
      .catch(error => {
        console.error("送信エラー:", error);
      });

    } else {
      let m = Math.floor(seconds / 60);
      let s = seconds % 60;
      display.innerText = m + "分" + (s < 10 ? "0" : "") + s + "秒";
      seconds--;
    }
  }, 1000);
}