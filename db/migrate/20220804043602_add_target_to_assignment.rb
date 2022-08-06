class AddTargetToAssignment < ActiveRecord::Migration[6.1]
  def change
    add_reference :assignments, :target, null: true, foreign_key: true
  end
end
