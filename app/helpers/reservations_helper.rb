# frozen_string_literal: true

module ReservationsHelper
  def gender_title(gender)
    case gender
    when 1
      "先生"
    when 2
      "小姐"
    end
  end
end
