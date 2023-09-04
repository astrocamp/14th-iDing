# frozen_string_literal: true

module ReservationsHelper
  def formatted_date(date)
    date.strftime("%m-%d")
  end

  def formatted_time(time)
    time.strftime('%R')
  end
end
