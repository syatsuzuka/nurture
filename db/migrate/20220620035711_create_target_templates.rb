class CreateTargetTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :target_templates do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.float :score, null: false
      t.references :target_templates_set, null: false, foreign_key: true
      t.timestamps
    end
  end
end
