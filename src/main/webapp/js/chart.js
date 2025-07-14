// 棒グラフの設定
let barCtx = document.getElementById("barChart");
let barConfig = {
	type: 'bar',
	data: {
		labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
		datasets: [{
			data: [10, 19, 6, 8, 2, 11],
			label: 'label',
			backgroundColor: [  // それぞれの棒の色を設定(dataの数だけ)
				'#ff0000',
				'#0000ff',
				'#ffff00',
				'#008000',
				'#800080',
				'#ffa500',
			],
			borderWidth: 1,
		}]
	},
};
let barChart = new Chart(barCtx, barConfig);