# frozen_string_literal: true

class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    twsms_account = Rails.application.credentials[:twsms][:account]
    twsms_password = Rails.application.credentials[:twsms][:password]

    sms_client = Twsms2::Client.new(username: ENV["TWSMS"], password: ENV["TWSMS_PASSWORD"])
    sms_client.send_message to: reservation.tel.to_s,
                            content: "您已預約#{reservation.restaurant.name}。於#{reservation.date}的#{reservation.time.strftime('%R')}。您的訂位資料：http://iding.cc/success_page/#{reservation.id}"
  end
end
