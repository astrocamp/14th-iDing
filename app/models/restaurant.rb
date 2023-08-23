# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  URL         :string           not null
#  tel         :string           not null
#  address     :string           not null
#  description :text
#  UBN         :string
#  image       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Restaurant < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :URL, presence: true
  validates :tel, presence: true
  validates :address, presence: true

  belongs_to :user

  has_many :reservations
  has_many :open_times
  has_many :tables, dependent: :destroy
end
