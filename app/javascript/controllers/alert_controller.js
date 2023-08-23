import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["field"];

  validateAndSubmit(event) {
    const nameValue = this.fieldTarget.value.trim();
    const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
    });

    if (nameValue === "") {
      event.preventDefault();
      Toast.fire({
        title: "錯誤",
        text: "桌號不可空白",
        icon: "error",
      });
    }
  }
}
