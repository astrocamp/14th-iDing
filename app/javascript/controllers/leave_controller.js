import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="leave"
export default class extends Controller {
  static values = { url: String };

  guestLeave(e) {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.urlValue}/leave`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    }).then(() => {
      const stateElement = document.querySelector(
        `#reservation-state-${this.urlValue}`
      );
      stateElement.textContent = "completed";
    });
  }
}
