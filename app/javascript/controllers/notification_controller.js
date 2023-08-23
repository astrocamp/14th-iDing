import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  connect() {
    const Toast = Swal.mixin({
      toast: true,
      position: "top",
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
    });

    const notice = this.data.get("notice");
    const alert = this.data.get("alert");

    if (notice) {
      Toast.fire({
        icon: "success",
        title: notice,
      });
    } else if (alert) {
      Toast.fire({
        icon: "error",
        title: alert,
      });
    }
  }
}
