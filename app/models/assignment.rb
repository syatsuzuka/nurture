class Assignment < ApplicationRecord
  validates :title, uniqueness: { scope: :course_id }
  validates :instruction, :checkpoint, presence: true
  belongs_to :course
  validate :check_status

  def check_checkpoint
    errors.add(:checkpoint, "can't be blank") if checkpoint.blank?
  end

  def check_status
    errors.add(:status, "can't be blank") if status.blank?
  end
end
