import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="holdseat"
export default class extends Controller {
  connect() {
    const { id } = this.element.dataset;
    this.id = id;
  }

  holdSeat() {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.id}/hold_seat`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    })
      .then((resp) => {
        console.log(resp);
      })
      .then((data) => {
        const newStateText = "已保留";
        const stateElement = document.querySelector(
          `#reservation-state-${this.id}`
        );

        if (stateElement) {
          stateElement.textContent = newStateText;
        }
      })
      .catch((err) => {
        console.error(err);
      });
  }
}
