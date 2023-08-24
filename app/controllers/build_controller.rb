class BuildController < ApplicationController
  include Wicked::Wizard

  steps :date_time_person, :customer_info

  def show
    case step
    when :date_time_person
    
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
            'adult_num' => params[:adult_num],
            'kid_num' => params[:kid_num],
          }

      puts session[:first_step_data]

      redirect_to wizard_path(:customer_info)

    when :customer_info
      
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.create!(
      name: params[:name],
      tel: params[:tel],
      email: params[:email],
      gender: params[:gender],
      date: session[:first_step_data]['date'],
      time: session[:first_step_data]['time'],
      adult_num: session[:first_step_data]['adult_num'],
      kid_num: session[:first_step_data]['kid_num'],
      purpose: params['purpose'],
      note: params['note']
    )
      if step == steps.last
      redirect_to success_page_path(reservation_id: @reservation.id)
      session.delete(:first_step_data)
      else
      render_wizard
      end
    end
  end

  def success_page
    @reservation = Reservation.find(params[:reservation_id])
  end 
end