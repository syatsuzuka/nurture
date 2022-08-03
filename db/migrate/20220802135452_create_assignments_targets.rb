class CreateAssignmentsTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments_targets do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true

      t.timestamps
    end
  end
end
