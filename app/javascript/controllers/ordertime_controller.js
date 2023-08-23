import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="ordertime"
export default class extends Controller {
  static targets = ["timebtn"];
  connect() {}

  clickTime(e) {
    e.preventDefault();
    console.log(e.target.value);
    const btnContent = e.target.value;
    this.timebtnTargets.forEach((btn) => {
      btn.value = btnContent;
    });
  }
}
