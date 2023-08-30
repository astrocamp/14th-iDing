import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = [
    "timeBtn",
    "timeInput",
    "dateInput",
    "dateBtn",
    "timeContainer",
  ];

  clickDate(e) {
    e.preventDefault();
    this.dateBtnTargets.forEach((btn) => {
      btn.classList.add("unselect-btn");
      btn.classList.remove("action-btn");
    });
    e.target.classList.remove("unselect-btn");
    e.target.classList.add("action-btn");
    this.dateInputTarget.value = e.target.value;

    const token = document
      .querySelector("meta[name=csrf-token]")
      .getAttribute("content");
    const ID = e.currentTarget.dataset.id;
    const selectedDate = e.target.value;

    fetch(`/restaurants/${ID}/filter_timelist`, {
      method: "POST", // 或'GET'，根據您的需求
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token, // 如果您的後端使用Rails，需要傳遞CSRF令牌
      },
      body: JSON.stringify({
        restaurant_id: ID,
        date: selectedDate,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        const timelist = data.timerange;
        const timeContainer = this.timeContainerTarget;

        timeContainer.innerHTML = "";
        timelist.forEach((timePoint) => {
          const button = document.createElement("button");
          button.className = "w-32 text-xl font-medium rounded-lg unselect-btn";
          button.setAttribute("data-ordertime-target", "timeBtn");
          button.setAttribute("data-action", "click->ordertime#clickTime");
          button.value = timePoint;
          button.textContent = timePoint;
          timeContainer.appendChild(button);
        });
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }

  clickTime(e) {
    e.preventDefault();
    this.timeBtnTargets.forEach((btn) => {
      btn.classList.add("unselect-btn");
      btn.classList.remove("action-btn");
    });
    e.target.classList.remove("unselect-btn");
    e.target.classList.add("action-btn");
    this.timeInputTarget.value = e.target.value;
  }
}
