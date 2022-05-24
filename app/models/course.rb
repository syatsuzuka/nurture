class Course < ApplicationRecord
  belongs_to :tutor, class_name: "User", optional: true
  belongs_to :student, class_name: "User", optional: true
  has_many :assignments, dependent: :destroy
  validate :student_or_tutor

  def student_or_tutor
    if tutor && student || tutor.nil? && student.nil?
      errors.add(:tutor_id, "Only 1 student or 1 tutor")
    end
  end
end
