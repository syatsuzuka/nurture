class Course < ApplicationRecord
  belongs_to :tutor, :class_name => "User", :foreign_key => :tutor_user_id
  belongs_to :student, :class_name => "User", :foreign_key => :student_user_id
  has_many :assignments, dependent: :destroy
  validate :check_name
  validate :check_description

  def check_name
    errors.add(:name, "is required") if name.blank?
  end

  def check_description
    errors.add(:description, "is required") if description.blank?
  end
end
