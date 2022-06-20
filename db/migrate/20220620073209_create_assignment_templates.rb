class CreateAssignmentTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_templates do |t|
      t.string :title, null: false
      t.text :instruction, null: false
      t.string :instruction_url
      t.text :checkpoint, null: false
      t.references :assignment_templates_set, null: false, foreign_key: true
      t.timestamps
    end
  end
end
