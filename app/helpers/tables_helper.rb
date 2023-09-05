# frozen_string_literal: true

module TablesHelper
  def table_image_and_name(table)
    current_time = Time.current + 8.hour
    one_hour_ago = current_time - 1.hour
    reservations = table.reservations.find_by(date: Date.today, time: one_hour_ago..current_time)

    if reservations.present?
      image_name = "table_occupy.png"
      reservation_name = reservations.name
    else
      image_name = "twinseat.png"
      reservation_name = ""
    end

    [image_name, reservation_name]
  end
end
