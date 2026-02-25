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

  validates :name, length: { maximum: 255 }
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validate :image_content_type_validation

  private

  def image_content_type_validation
    return unless image.attached?

    allowed_types = ['image/jpeg', 'image/png', 'image/gif']
    unless allowed_types.include?(image.content_type)
      errors.add(:image, :content_type_invalid)
      image.purge
    end
  end

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
