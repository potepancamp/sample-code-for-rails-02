class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :content
    validates :address
    validates :price
  end

  validates :price, numericality: { only_integer: true, greater_than: 0 }

  scope :search_by_area, -> (area) {
    if area.present?
      where("address like ?", "%#{area}%")
    end
  }

  scope :search_by_keyword, -> (keyword) {
    if keyword.present?
      where("name like ? or content like ?", "%#{keyword}%", "%#{keyword}%")
    end
  }
end
