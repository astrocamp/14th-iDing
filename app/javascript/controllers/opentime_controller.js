import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="opentime"
export default class extends Controller {
  static targets = ["startTime", "endTime", "submit"];

  connect() {
    this.checkstartTime();
  }

  updateTime(targetName) {
    const [hr, min] = this[targetName + "Targets"].map((input) =>
      parseInt(input.value, 10)
    );
    return new Date(2023, 8, 20, hr, min);
  }

  checkstartTime() {
    this.startTime = this.updateTime("startTime");
    this.compareTime();
  }

  checkendTime() {
    this.endTime = this.updateTime("endTime");
    this.compareTime();
  }

  compareTime() {
    const TimeCorrect = this.startTime < this.endTime;
    this.submitTarget.classList.toggle("void-btn", !TimeCorrect);
    this.submitTarget.classList.toggle("action-btn", TimeCorrect);
    this.submitTarget.disabled = !TimeCorrect;
  }
}
