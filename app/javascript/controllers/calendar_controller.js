import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core/index.js";
import interactionPlugin__default from "@fullcalendar/interaction/index.js";
import dayGridPlugin from "@fullcalendar/daygrid/index.js";
import timeGridPlugin from "@fullcalendar/timegrid/index.js";
import listPlugin from "@fullcalendar/list/index.js";
import multiMonthPlugin from "@fullcalendar/multimonth/index.js";
import zhLocale from "@fullcalendar/core/locales/zh-tw.js";

export default class extends Controller {
  static values = { restaurantId: Number };
  connect() {
    const calendarEl = document.getElementById("calendar");
    const calendar = new Calendar(calendarEl, {
      locale: zhLocale,
      navLinks: true,
      plugins: [
        interactionPlugin__default,
        dayGridPlugin,
        timeGridPlugin,
        listPlugin,
        multiMonthPlugin,
      ],
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay,listWeek",
      },
      timeZone: "UTC",
      events: `/api/v1/restaurants/${this.restaurantIdValue}/reservations`,
      eventTimeFormat: {
        hour: "2-digit",
        minute: "2-digit",
        meridiem: false,
        hour12: false,
      },
    });
    calendar.render();
  }
}
