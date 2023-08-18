# frozen_string_literal: true

class Restaurant < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :URL, presence: true
  validates :tel, presence: true
  validates :address, presence: true

  belongs_to :user
  has_many :open_times
end
