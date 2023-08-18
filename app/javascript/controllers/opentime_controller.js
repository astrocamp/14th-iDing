import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="opentime"
export default class extends Controller {
  static targets = ["SrartTime", "CloseTime", "submit"];

  connect() {
    this.getOpeningTime();
  }

  getOpeningTime() {
    const openingTimeHr = this.openingTimeTargets[0].value;
    const openingTimeMin = this.openingTimeTargets[1].value;
    this.openingTime = new Date(
      `2000-01-01 ${openingTimeHr}:${openingTimeMin}:00 +0800`
    );
    this.compareTime();
  }

  getClosedTime() {
    const closedTimeHr = this.closedTimeTargets[0].value;
    const closedTimeMin = this.closedTimeTargets[1].value;
    this.closedTime = new Date(
      `2000-01-01 ${closedTimeHr}:${closedTimeMin}:00 +0800`
    );
    this.compareTime();
  }

  compareTime() {
    if (this.openingTime < this.closedTime) {
      this.submitTarget.classList.remove("disabled-btn");
      this.submitTarget.classList.add("major-btn");
    } else {
      this.submitTarget.classList.add("disabled-btn");
      this.submitTarget.classList.remove("major-btn");
    }
  }
}
