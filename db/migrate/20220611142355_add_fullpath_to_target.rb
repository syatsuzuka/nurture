class AddFullpathToTarget < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :fullpath, :string
  end
end
