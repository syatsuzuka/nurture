class DeleteFullpathFromTarget < ActiveRecord::Migration[6.1]
  def change
    remove_column :targets, :fullpath
  end
end
