class Assignment < ApplicationRecord
  validates :title, :instruction, :comment, :checkpoint, presence: true
  belongs_to :course
  validate :check_status

  def check_status
    errors.add(:status, "can't be blank") if status.blank?
  end
end
