# frozen_string_literal: true

# == Schema Information
#
# Table name: tables
#
#  id         :bigint           not null, primary key
#  name       :string
#  seat_num   :integer
#  status     :string
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Table < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :seat_num, presence: true, numericality: { greater_than: 0 }

  enum category: { '一般座位': 0, '包廂': 1 }
end
