import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin__default from "@fullcalendar/interaction";
import multiMonthPlugin from "@fullcalendar/multimonth";
import zhLocale from "@fullcalendar/core/locales/zh-tw";

export default class extends Controller {
  static values = { restaurantId: Number };
  connect() {
    const calendarEl = document.getElementById("calendar");
    let redirectToUrl = `/admin/restaurants/${this.restaurantIdValue}`;
    const calendar = new Calendar(calendarEl, {
      locale: zhLocale,
      plugins: [
        interactionPlugin__default,
        dayGridPlugin,
        timeGridPlugin,
        listPlugin,
        multiMonthPlugin,
      ],
      headerToolbar: {
        left: "prev,next",
        center: "title",
        right: "today",
      },
      timeZone: "UTC",
      events: `/api/v1/restaurants/${this.restaurantIdValue}/reservations`,
      eventTimeFormat: {
        hour: "2-digit",
        minute: "2-digit",
        meridiem: false,
        hour12: false,
      },
      navLinks: true,
      navLinkDayClick: function (date, event) {
        event.preventDefault();
        let year = date.getFullYear();
        let month = (date.getMonth() + 1).toString().padStart(2, "0");
        let day = date.getDate().toString().padStart(2, "0");
        window.location.href = redirectToUrl + `?date=${year}-${month}-${day}`;
      },
    });
    calendar.render();
  }
}
