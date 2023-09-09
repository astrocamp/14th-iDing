import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = [
    "timeBtn",
    "timeInput",
    "dateInput",
    "dateBtn",
    "timeContainer",
    "fullyBooked",
    "submitBtn",
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
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
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
        this.fullyBookedTarget.classList.add("hidden");
        if (timelist.length == 0) {
          this.fullyBookedTarget.classList.remove("hidden");
        }
        timelist.forEach((timePoint) => {
          const button = document.createElement("button");
          button.className =
            "max-w-sm mx-2 my-2 text-lg font-medium rounded-lg lg:mx-auto lg:my-2 lg:text-lg lg:w-32 unselect-btn";
          button.setAttribute("data-ordertime-target", "timeBtn");
          button.setAttribute("data-action", "click->ordertime#clickTime");
          button.value = timePoint;
          button.textContent = timePoint;
          timeContainer.appendChild(button);
        });
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

  checkData() {
    const dateValue = this.dateInputTarget.value;
    console.log(dateValue);
    const timeValue = this.timeInputTarget.value;
    console.log(timeValue);
    const Enable = dateValue && timeValue;
    // this.submitBtnTarget.toggleAttribute("disabled", !shouldEnable);
    this.submitBtnTarget.classList.toggle("next-btn", Enable);
    this.submitBtnTarget.classList.toggle("next-btn-void", !Enable);
    this.submitBtnTarget.disabled = !Enable;
  }
}
