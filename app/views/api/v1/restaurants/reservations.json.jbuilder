# frozen_string_literal: true

json.array! @reservations do |reservation|
  title = "[#{reservation.tel.last(3)}] #{reservation.name} (#{reservation.adults}+#{reservation.kids})"
  json.title title

  date = reservation.date
  started_at = reservation.time.change(year: date.year, month: date.month, day: date.day)
  json.start started_at
end
