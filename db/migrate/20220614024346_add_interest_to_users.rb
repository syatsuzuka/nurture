class AddInterestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :interest, :string
  end
end
