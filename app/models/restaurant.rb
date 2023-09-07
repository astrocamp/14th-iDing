# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  url              :string           not null
#  tel              :string           not null
#  address          :string           not null
#  description      :text
#  ubn              :string
#  image            :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reserve_interval :integer          default(15)
#  mealtime         :integer          default(60)
#  bookday_advance  :integer          default(14)
#
class Restaurant < ApplicationRecord
  acts_as_paranoid
  
  mount_uploader :image, ImageUploader
  mount_uploaders :menus, MenuUploader

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
  validates :tel, presence: true
  validates :address, presence: true

  belongs_to :user

  has_many :reservations, dependent: :destroy
  has_many :open_times, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :holidays, dependent: :destroy
end
