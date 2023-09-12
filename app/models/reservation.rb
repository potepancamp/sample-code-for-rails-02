class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  with_options presence: true do
    validates :start_date
    validates :end_date
    validates :person_num
  end

  validate :start_date_must_after_today
  validate :end_date_must_after_start_date

  validates :person_num, numericality: { only_integer: true, greater_than: 0 }

  def start_date_must_after_today
    errors.add(:start_date, "は本日以降の日付で選択してください。") if start_date.present? && start_date < Date.current
  end

  def end_date_must_after_start_date
    errors.add(:end_date, "はチェックイン日より後の日付で選択してください。") if start_date.present? && end_date.present? && end_date <= start_date
  end

  def total_amount
    room.price * person_num * (end_date - start_date).to_i
  end
end
