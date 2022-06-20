class CreateTargetTemplatesSets < ActiveRecord::Migration[6.1]
  def change
    create_table :target_templates_sets do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.boolean :visible
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
