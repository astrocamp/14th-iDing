# frozen_string_literal: true

module RestaurantsHelper
  
  def table_select_options(restaurant)
  
    vacant_options = restaurant.tables.where(status: "vacant").order(:name).map do |table|
      ["#{table.name} - #{table.category}", table.id]
    end

    occupied_options = restaurant.tables.where(status: "occupied").order(:name).map do |table|
      ["#{table.name} - #{table.category}", table.id, { disabled: "disabled" }]
    end

    grouped_options = {
      "空缺" => vacant_options,
      "使用中" => occupied_options
    }
    select_tag :table_id, grouped_options_for_select(grouped_options)
  end

end
