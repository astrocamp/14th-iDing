import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="check-in"
export default class extends Controller {
  connect() {
    const { id } = this.element.dataset;
    this.id = id;
  }
  checkIn(e) {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.id}/check_in`;

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
        stateElement.textContent = "used";
      }
    });
  }
}
