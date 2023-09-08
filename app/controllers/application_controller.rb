# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized # 還要切個畫面
  around_action :switch_locale

  private

  def not_found
    render file: Rails.root.join('public', '404.html'),
           status: 404,
           layout: false
  end

  def user_not_authorized
    flash[:alert] = "您無權訪問此頁面。"
    redirect_to(request.referrer || root_path)
  end
  
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
