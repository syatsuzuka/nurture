class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.references :tutor, null: false, foreign_key: { to_table: :users }
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
