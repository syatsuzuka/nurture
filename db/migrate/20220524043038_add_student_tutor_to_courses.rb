class AddStudentTutorToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :tutor_user_id, :integer, index: true, foreign_key: true
    add_column :courses, :student_user_id, :integer, index: true, foreign_key: true
  end
end
