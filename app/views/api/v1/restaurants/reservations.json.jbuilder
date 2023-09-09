# frozen_string_literal: true

json.array! @reservations.group_by(&:date) do |date, reservations|
  title = "目前有 #{reservations.count} 筆訂位"
  json.title title

  started_at = reservations.first.time.change(year: date.year, month: date.month, day: date.day)
  json.start started_at
end
