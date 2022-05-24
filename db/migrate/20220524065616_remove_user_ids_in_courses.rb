class RemoveUserIdsInCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :student_user_id, :integer
    remove_column :courses, :tutor_user_id, :integer

    add_reference :courses, :user, null: false, foreign_key: true
  end
end
