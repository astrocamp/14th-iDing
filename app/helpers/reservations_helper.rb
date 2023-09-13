# frozen_string_literal: true

module ReservationsHelper
  def gender_title(gender)
    case gender
    when 1
      I18n.t('customerInfo.Mr_')
    when 2
      I18n.t('customerInfo.Ms_')
    else
      ''
    end
  end
end
