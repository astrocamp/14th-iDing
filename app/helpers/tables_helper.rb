# frozen_string_literal: true

module TablesHelper
  def table_image_and_name(table, restaurant)
    current_time = Time.current + 8.hour
    one_hour_ago = current_time - restaurant.mealtime.minutes
    reservation = table.reservations.where(date: Date.today).where(state: 'used').order(time: :desc).first

    if reservation.present? && table.status == 'occupied'
      image_name = 'table_occupy.png'
      reservation_name = reservation.name
      reservation_time = reservation.time.strftime('%R')
    else
      image_name = 'twinseat.png'
      reservation_name = ''
      reservation_time = ''
    end

    [image_name, reservation_name, reservation_time]
  end
end
