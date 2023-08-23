# frozen_string_literal: true

module HomeHelper
  def user_name
    current_user.email.split('@').first.capitalize
  end

  # def vao7e(session)
  #   if session
  #     session[:date]
  #   else
  #     nil
  #   end
end
