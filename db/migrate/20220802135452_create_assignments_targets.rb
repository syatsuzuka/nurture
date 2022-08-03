class CreateAssignmentsTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments_targets do |t|
      t.references :assignment, null: true, foreign_key: true
      t.references :target, null: true, foreign_key: true

      t.timestamps
    end
  end
end
