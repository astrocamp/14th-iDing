import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core/index.js";
import interactionPlugin__default from "@fullcalendar/interaction/index.js";
import dayGridPlugin from "@fullcalendar/daygrid/index.js";
import timeGridPlugin from "@fullcalendar/timegrid/index.js";
import listPlugin from "@fullcalendar/list/index.js";
import multiMonthPlugin from "@fullcalendar/multimonth/index.js";

export default class extends Controller {
  connect() {
    const calendarEl = document.getElementById("calendar");
    const calendar = new Calendar(calendarEl, {
      height: 750,
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
    });
    calendar.render();
  }
}
