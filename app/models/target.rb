class Target < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :course
  validate :check_name
  validate :check_description
  validate :check_score

  def check_name
    errors.add(:name, "is required") if name.blank?
  end

  def check_description
    errors.add(:description, "is required") if description.blank?
  end

  def check_score
    errors.add(:score, "is required") if score.blank?
  end
end
