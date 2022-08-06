class DeleteAssignmentsTarget < ActiveRecord::Migration[6.1]
  def change
    drop_table :assignments_targets
  end
end
