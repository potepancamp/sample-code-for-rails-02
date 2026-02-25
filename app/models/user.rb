class User < ApplicationRecord
  has_one_attached :image

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :rooms
  has_many :reservations

  validates :name, presence: true
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
end
