class AddDateToAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :assignments, :start_date, :date
    add_column :assignments, :end_date, :date
  end
end
