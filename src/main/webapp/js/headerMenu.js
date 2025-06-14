// MENUのindex（div要素）を取得
const menuIndex = document.querySelector(".menu_index");

// トグルボタン要素を取得
const toggleBtn = document.querySelector(".toggle_btn");

// メニューのul要素を取得
const menuContainer = document.querySelector(".menu_container");

// ul要素の縦幅を取得して、translateYで上に移動させておく
// (clientHeightはboreder幅を含めないので、borderの幅を足す)
const menuContainerHeight = menuContainer.clientHeight;
menuContainer.style.transform = `translateY(-${menuContainerHeight + 1}px)`;

// MENUのindex（div要素）がクリックされたら
menuIndex.addEventListener("click", () => {

	// トグルボタン要素にactiveクラスを付けたり外したりする
	toggleBtn.classList.toggle("active");

	// opacityで隠しておいたメニューを表示（以降、opactyは1のままで良い）
	menuContainer.style.opacity = 1;

	// ul要素にacitveクラスが含まれていなければクラスを付与し、transformで移動
	if (!menuContainer.classList.contains("active")) {
		menuContainer.classList.add("active");
		menuContainer.style.transform = "translateY(0)";
	} else {
		// そうでない場合はactiveクラスを外してtransformで移動
		menuContainer.classList.remove("active");
		menuContainer.style.transform = `translateY(-${menuContainerHeight + 1}px)`;
	}
});
