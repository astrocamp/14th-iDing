import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="opentime"
export default class extends Controller {
  static targets = ["startTime", "closeTime", "submit"];

  connect() {
    this.getstartTime();
  }

  getstartTime() {
    const startTimeHr = this.startTimeTargets[0].value;
    const startTimeMin = this.startTimeTargets[1].value;
    this.startTime = new Date(
      `2000-01-01 ${startTimeHr}:${startTimeMin}:00 +0800`
    );
    this.compareTime();
  }

  getcloseTime() {
    const closeTimeHr = this.closeTimeTargets[0].value;
    const closeTimeMin = this.closeTimeTargets[1].value;
    this.closeTime = new Date(
      `2000-01-01 ${closeTimeHr}:${closeTimeMin}:00 +0800`
    );
    this.compareTime();
  }

  compareTime() {
    if (this.startTime < this.closeTime) {
      this.submitTarget.classList.remove("disabled-btn");
      this.submitTarget.classList.add("major-btn");
    } else {
      this.submitTarget.classList.add("disabled-btn");
      this.submitTarget.classList.remove("major-btn");
    }
  }
}
