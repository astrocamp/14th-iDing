# frozen_string_literal: true

module RestaurantsHelper
  def table_select_options(restaurant, form)
    vacant_options = restaurant.tables.where(status: 'vacant').order(:name).map do |table|
      ["#{table.name} - #{table.category}", table.id]
    end

    occupied_options = restaurant.tables.where(status: 'occupied').order(:name).map do |table|
      ["#{table.name} - #{table.category}", table.id, { disabled: 'disabled' }]
    end

    grouped_options = {
      '空缺' => vacant_options,
      '使用中' => occupied_options
    }

    form.select :table_id, grouped_options, { prompt: '桌號' }
  end
end
