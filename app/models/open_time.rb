# frozen_string_literal: true

# == Schema Information
#
# Table name: open_times
#
#  id            :bigint           not null, primary key
#  start_time    :time
#  end_time      :time
#  restaurant_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OpenTime < ApplicationRecord
  belongs_to :restaurant
  validates :end_time, comparison: { greater_than: :start_time }
end
