class AddDeactivatedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deactivated, :boolean
  end
end
