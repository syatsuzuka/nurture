class Course < ApplicationRecord
  belongs_to :tutor, :class_name => "User", :foreign_key => :tutor_user_id
  belongs_to :student, :class_name => "User", :foreign_key => :student_user_id

end
