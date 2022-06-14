class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :message, :text
    add_column :users, :specialty, :string
  end
end
