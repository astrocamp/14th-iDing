import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="customerinfo"
export default class extends Controller {
  static targets = ["nameInput", "telInput", "submitBtn"];

  checkData() {
    const nameValue = this.nameInputTarget.value;
    const telValue = this.telInputTarget.value;
    const Enable = nameValue && telValue;
    this.submitBtnTarget.classList.toggle("next-btn", Enable);
    this.submitBtnTarget.classList.toggle("next-btn-void", !Enable);
    this.submitBtnTarget.disabled = !Enable;
  }
}
