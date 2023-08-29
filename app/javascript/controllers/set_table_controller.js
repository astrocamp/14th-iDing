import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="set-table"
export default class extends Controller {
  connect() {
    console.log("123");
  }
}
