# == Schema Information
#
# Table name: holidays
#
#  id            :bigint           not null, primary key
#  dayoff        :date
#  restaurant_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Holiday < ApplicationRecord
  belongs_to :restaurant
end
