import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timebtn"
export default class extends Controller {
  connect() {}

  preventDefault(event) {
    event.preventDefault();
    // const hiddenRadio = event.currentTarget.querySelector(".hidden-radio");
    // hiddenRadio.click();
  }
}
