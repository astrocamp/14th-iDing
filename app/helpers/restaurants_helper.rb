module RestaurantsHelper
  class TimeRange
    def initialize(opening_time, reserve_interval)
      @opening_time = opening_time
      @reserve_interval = reserve_interval.minutes.to_i
    end

    def time_collection
      @time_points = @opening_time.reduce([]) { |arr, time| arr << (time.opening_time.to_i..time.closed_time.to_i) }
    end

    def reserve_interval
      @time_points.each_with_object([]) do |time, arr|
        time.step(@reserve_interval) { |t| arr << Time.at(t).strftime('%R') }
      end
    end
  end
end