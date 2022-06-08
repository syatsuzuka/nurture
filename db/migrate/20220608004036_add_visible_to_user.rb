class AddVisibleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :visible, :boolean, default: true
  end
end
