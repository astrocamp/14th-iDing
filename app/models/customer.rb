# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  tel        :string           not null
#  email      :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
class Customer < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :tel, presence: true

  has_many :reservations
  accepts_nested_attributes_for :reservations,
                                allow_destroy: true
end
