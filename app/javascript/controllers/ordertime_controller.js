import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = ["timeBtn", "timeInput", "dateInput", "dateBtn"];
  connect() {}

  clickTime(e) {
    e.preventDefault();
    this.timeInputTarget.value = e.target.value;
  }

  clickDate(e) {
    e.preventDefault();
    this.dateInputTarget.value = e.target.value;
  }
}
