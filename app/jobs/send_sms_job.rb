# frozen_string_literal: true

class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    sms_client = Twsms2::Client.new(username: ENV.fetch('TWSMS', nil), password: ENV.fetch('TWSMS_PASSWORD', nil))
    sms_client.send_message to: reservation.tel.to_s,
                            content: "您已預約#{reservation.restaurant.name}。於#{reservation.date}的#{reservation.time.strftime('%R')}。您的訂位資料：https://iding.cc/success_page/#{reservation.slug}"
  end
end
