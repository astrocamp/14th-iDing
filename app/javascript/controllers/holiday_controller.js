import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="holiday"
export default class extends Controller {
  static targets = ["input", "date", "dayOff", "submit"];

  connect() {
    const offDay = this.dayOffTargets.map((a) => a.dataset.date);
    this.dateTargets.forEach((btn) => {
      if (offDay.includes(btn.dataset.date)) {
        btn.classList.add("hidden");
      }
    });
  }

  getDate(e) {
    this.dateTargets.forEach((btn) => btn.classList.add("gray-btn"));
    this.dateTargets.forEach((btn) => btn.classList.remove("action-btn"));
    e.target.classList.remove("gray-btn");
    e.target.classList.add("action-btn");
    this.setDate(e.target.dataset.date);
  }
  setDate(date) {
    this.inputTarget.value = date;
    this.submitTarget.classList.remove("void-btn");
    this.submitTarget.classList.add("action-btn");
  }
}
