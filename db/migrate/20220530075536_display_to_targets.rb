class DisplayToTargets < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :display, :boolean, default: true
  end
end
