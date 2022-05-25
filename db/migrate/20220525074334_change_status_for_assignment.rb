class ChangeStatusForAssignment < ActiveRecord::Migration[6.1]
  def up
      change_column :assignments, :status, :integer, using: 'status::integer'
  end

  def down
      change_column :assignments, :status, :boolean
  end
end
