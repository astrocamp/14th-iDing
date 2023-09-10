import { Controller } from "@hotwired/stimulus";
import introJs from "intro.js";

export default class extends Controller {
  connect() {
    const intro = introJs();
    const introCompleted = localStorage.getItem("introCompleted");
    if (introCompleted) {
      return; // Exit the function if intro has already been completed
    }
    intro.setOptions({
      exitOnOverlayClick: false,
      showStepNumbers: true,
      disableInteraction: true,
      highlightClass: "highlight",
      tooltipClass: "tooltip",
      nextLabel: "下一步",
      prevLabel: "上一步",
      doneLabel: "開始體驗iDing吧！",
      steps: [
        {
          title: "歡迎加入iDing！",
          intro: "我們將帶您了解如何輕鬆管理您的餐廳訂位。",
        },
        {
          title: "訂位總覽",
          intro: "您可以在這裡輕鬆查看所有的訂位記錄。",
          element: ".reservationList",
        },
        {
          title: "新增訂位",
          intro: "您可以直接在這裡新增餐廳的訂位。",
          element: ".addreservation",
        },
        {
          title: "訂位搜尋",
          intro: "有了訂位搜尋功能，<br>您可以輕鬆查找和管理餐廳內的歷史訂單。",
          element: ".introSearch",
        },
        {
          title: "餐廳資訊",
          intro: "編輯您餐廳的基本資訊，<br>讓消費者更快速的了解您的餐廳。",
          element: ".introRestaurant",
        },
        {
          title: "行事曆",
          intro:
            "您可以在行事曆中查看餐廳<br>每個月的訂位分布情況，<br>並點選日期以同步篩選當天的訂位。",
          element: ".introCalender",
        },
        {
          title: "桌位圖",
          intro:
            "這裡可以新增餐廳的平面圖，同時查看當天的訂位情況。為您的顧客提供更好的用餐體驗。",
          element: ".introTable",
        },
        {
          title: "設定營業時間",
          intro:
            "為了讓消費者能夠在網頁上看到您的餐廳開放時間，請先設定營業時間。",
          element: ".addTime",
        },
        {
          title: "設定餐廳座位",
          intro:
            "接著，請您設定餐廳內的座位。<br>設定完營業時間和座位後，消費者才能在您的網頁上預訂餐廳的位置。",
          element: ".addTable",
        },
      ],
    });
    intro.oncomplete(function () {
      // Set introCompleted flag in localStorage
      localStorage.setItem("introCompleted", "true");
    });
    intro.onbeforeexit(function () {
      localStorage.setItem("introCompleted", "true");
    });

    intro.start();
  }
}
