# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  tel        :string           not null
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
  validates :name, presence: true
  validates :tel, presence: true
  validates :date, presence: true
  validates :time, presence: true

end
