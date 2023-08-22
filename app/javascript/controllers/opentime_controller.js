import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="opentime"
export default class extends Controller {
  static targets = ["startTime", "endTime", "submit"];

  connect() {
    this.compareTime();
  }

  compareTime() {
    const TimeCorrect =
      this.startTimeTargets[0].value < this.endTimeTargets[0].value;
    this.submitTarget.classList.toggle("void-btn", !TimeCorrect);
    this.submitTarget.classList.toggle("action-btn", TimeCorrect);
    this.submitTarget.disabled = !TimeCorrect;
  }
}
