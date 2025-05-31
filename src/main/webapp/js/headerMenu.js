// MENUのindex（div要素）を取得
const menuIndex = document.querySelector(".menu_index");

// トグルボタン要素を取得
const toggleBtn = document.querySelector(".toggle_btn");

// MENUのindex（div要素）がクリックされたら
menuIndex.addEventListener("click", () => {

    // トグルボタン要素にactiveクラスを付けたり外したりする
    toggleBtn.classList.toggle("active");

});
