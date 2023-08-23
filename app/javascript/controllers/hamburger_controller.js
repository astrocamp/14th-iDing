import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="hamburger"
export default class extends Controller {
  static targets = ["nav"];

  switch() {
    this.navTarget.classList.toggle("hidden");
  }
}
