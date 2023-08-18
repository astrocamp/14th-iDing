# == Schema Information
#
# Table name: open_times
#
#  id            :bigint           not null, primary key
#  start_time    :time
#  close_time    :time
#  restaurant_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OpenTime < ApplicationRecord
  belongs_to :restaurant
end
