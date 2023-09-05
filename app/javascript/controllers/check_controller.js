import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="check-in"
export default class extends Controller {
  static values = { url: String };

  checkIn() {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.urlValue}/check_in`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    }).then(() => {
      const stateElement = document.querySelector(
        `#reservation-state-${this.urlValue}`
      );
      return (stateElement.textContent = "used");
    });
  }
}
