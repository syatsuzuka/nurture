class FixKeysInCourses < ActiveRecord::Migration[6.1]
  def change
    remove_reference :courses, :tutor, null: false, foreign_key: { to_table: :users }
    remove_reference :courses, :student, null: false, foreign_key: { to_table: :users }

    add_reference :courses, :tutor, foreign_key: { to_table: :users }
    add_reference :courses, :student, foreign_key: { to_table: :users }
  end
end
