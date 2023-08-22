module RestaurantsHelper
  class TimeRange
    def initialize(open_time, reserve_interval)
      @open_time = open_time
      @reserve_interval = reserve_interval.minutes.to_i
    end

    def time_collection
      @time_points = @open_time.reduce([]) { |arr, time| arr << (time.start_time.to_i..time.end_time.to_i) }
    end

    def reserve_interval
      @time_points.each_with_object([]) do |time, arr|
        time.step(@reserve_interval) { |t| arr << Time.at(t).strftime('%R') }
      end
    end
  end
end