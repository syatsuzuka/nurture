class AddParentIdToTarget < ActiveRecord::Migration[6.1]
  def change
    add_reference :targets, :parent, foreign_key: { to_table: :targets }
  end
end
