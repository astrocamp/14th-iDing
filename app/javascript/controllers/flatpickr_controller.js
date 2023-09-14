import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    let dateFormat = "H:i";
    const inputType = this.element.type;

    if (inputType === "date") {
      dateFormat = "Y-m-d";
    } else if (inputType === "time") {
      dateFormat = "H:i";
    }

    flatpickr(this.element, {
      enableTime: true,
      noCalendar: inputType === "time",
      dateFormat: dateFormat,
      time_24hr: inputType === "time",
    });
  }
}
