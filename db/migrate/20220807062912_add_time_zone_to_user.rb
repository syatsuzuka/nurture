class AddTimeZoneToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :time_zone, :string
  end
end
