class AddStatusToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :status, :integer
  end
end
