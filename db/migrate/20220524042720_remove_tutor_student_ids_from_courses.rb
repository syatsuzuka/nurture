class RemoveTutorStudentIdsFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :student_id
    remove_column :courses, :tutor_id
  end
end
