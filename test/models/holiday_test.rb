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
require "test_helper"

class HolidayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
