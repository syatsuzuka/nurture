class AddViewedAtToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :viewed_at, :datetime, null: true
  end
end
