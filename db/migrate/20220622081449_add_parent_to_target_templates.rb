class AddParentToTargetTemplates < ActiveRecord::Migration[6.1]
  def change
    add_reference :target_templates, :parent, foreign_key: { to_table: :target_templates }
  end
end
