import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = ["timeBtn", "timeInput", "dateInput", "dateBtn"];
  connect() {}

  clickTime(e) {
    e.preventDefault();
    const btnContent = e.target.value;
    this.timeInputTarget.value = btnContent;
  }

  clickDate(e) {
    e.preventDefault();
    const btnContent = e.target.value;
    this.dateInputTarget.value = btnContent;
  }
}
