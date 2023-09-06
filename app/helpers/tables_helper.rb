# frozen_string_literal: true

module TablesHelper
  def table_image_and_name(table, restaurant)
    current_time = Time.current + 8.hour
    one_hour_ago = current_time - restaurant.mealtime.minutes
    reservations = table.reservations.find_by(date: Date.today, time: one_hour_ago..current_time)

    if reservations.present? && table.status == "occupied"
      image_name = "table_occupy.png"
      reservation_name = reservations.name
      reservation_time = reservations.time.strftime("%R")
    else
      image_name = "twinseat.png"
      reservation_name = ""
      reservation_time = ""
    end

    [image_name, reservation_name, reservation_time]
  end
end
