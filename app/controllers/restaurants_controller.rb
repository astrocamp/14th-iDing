# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, :set_holidays, :set_timelist, :set_daylist, only: [:show]

  def index
    @restaurants = Restaurant.order(:id)
  end

  def show
    @open_time = @restaurant.open_times.order(:start_time)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # TimeRange
  def time_slot
    time_periods = @restaurant.open_times.pluck(:start_time, :end_time)
    @time_period = time_periods.map { |start_time, end_time| start_time.to_i..end_time.to_i }
  end

  def set_timelist
    time_slot
    @timerange = @time_period.each_with_object([]) do |time, arr|
      time.step(@restaurant.reserve_interval.minutes) { |t| arr.push(Time.at(t).utc.strftime('%R')) }
    end
  end

  # DateRange
  def set_holidays
    @holidays = @restaurant.holidays.where.not(dayoff: nil).pluck(:dayoff)
  end

  def set_daylist
    @end_day = Date.today + @restaurant.bookday_advance
    @daterange = (Date.today..@end_day).select { |date| @holidays.exclude?(date.strftime('%a')) }
  end

  def filter_timelist
    @restaurant = Restaurant.find(params[:restaurant_id])
    selected_date = params[:date].to_date
    time_slot
    @timerange = []

    @time_period.each do |time_range|
      time_range.step(@restaurant.reserve_interval.minutes) do |time|
        end_time = time + @restaurant.mealtime.minutes
        reservations_count = @restaurant.reservations.where(date: selected_date, time: time..end_time).count
        available_tables = @restaurant.tables.count - reservations_count

        if available_tables.positive?
          @timerange << Time.at(time).utc.strftime('%R')
        end
      end
    end
    render json: { timerange: @timerange }
  end
end
