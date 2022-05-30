class Progress < ApplicationRecord
  belongs_to :target
  validate :check_date
  validate :check_score

  def check_date
    errors.add(:date, "is required") if date.blank?
  end

  def check_score
    errors.add(:score, "is required") if score.blank?
  end
end
