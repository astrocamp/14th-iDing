# frozen_string_literal: true

class BuildController < ApplicationController
  include Wicked::Wizard
  before_action :set_restaurant, only: %i[show update]
  before_action :set_holidays, :set_timelist, :set_daylist, only: [:show]

  steps :date_time_person, :customer_info

  def show
    case step
    when :date_time_person
      @open_time = @restaurant.open_times.order(:start_time)

    when :customer_info
      @first_step = session[:first_step_data]
    end
    render_wizard
  end

  def update
    case step
    when :date_time_person
      session[:first_step_data] = {
        'date' => params[:date],
        'time' => params[:time],
        'adults' => params[:adults],
        'kids' => params[:kids]
      }

      redirect_to wizard_path(:customer_info)

    when :customer_info

      @reservation = @restaurant.reservations.create!(reservation_params)
      if step == steps.last
        redirect_to success_page_path(reservation_id: @reservation.id), notice: '訂位成功！'
        session.delete(:first_step_data)
      else
        render_wizard
      end
    end
  end

  def success_page
    @reservation = Reservation.find(params[:reservation_id])
  end

  private

  def reservation_params
    params.permit(
      :name,
      :tel,
      :email,
      :gender,
      :purpose,
      :note,
      :table_id
    ).merge(
      date: session[:first_step_data]['date'],
      time: session[:first_step_data]['time'],
      adults: session[:first_step_data]['adults'],
      kids: session[:first_step_data]['kids']
    )
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
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
    end.sort
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
    selected_date = params[:date]
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
