import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = ["timeBtn", "timeInput", "dateInput", "dateBtn"];

  clickDate(e) {
    e.preventDefault();
    this.dateBtnTargets.forEach((btn) => {
      btn.classList.add("unselect-btn");
      btn.classList.remove("action-btn");
    });
    e.target.classList.remove("unselect-btn");
    e.target.classList.add("action-btn");
    this.dateInputTarget.value = e.target.value;
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
