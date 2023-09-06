import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="holdseat"
export default class extends Controller {
  static values = { url: String };

  holdSeat() {
    const token = document.querySelector("meta[name=csrf-token]").content;
    const url = `/api/v1/reservations/${this.urlValue}/hold_seat`;

    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": token,
      },
    }).then(() => {
      const newStateText = I18n.t("success.Reservation confirmed");
      const stateElement = document.querySelector(
        `#reservation-state-${this.urlValue}`
      );
      return (stateElement.textContent = newStateText);
    });
  }
}
