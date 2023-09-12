class User < ApplicationRecord
  has_one_attached :image

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :rooms
  has_many :reservations

  validates :name, presence: true
end
