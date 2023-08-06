# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string
#  tel        :string
#  email      :string
#  date       :date
#  time       :time
#  purpose    :string
#  note       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
