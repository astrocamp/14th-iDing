import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="leave"
export default class extends Controller {
  connect() {
    const { id } = this.element.dataset;
    this.id = id;
  }
  guestLeave(e) {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.id}/leave`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    }).then((resp) => {
      if (resp.ok) {
        const stateElement = document.querySelector(
          `#reservation-state-${this.id}`
        );
        stateElement.textContent = "completed";
      }
    });
  }
}
