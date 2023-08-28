# frozen_string_literal: true

module BulidHelper
  def chinese_weekday(date)
    %w[日 一 二 三 四 五 六][date.wday]
  end
end
