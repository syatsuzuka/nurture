class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :instruction
      t.text :comment
      t.text :checkpoint
      t.boolean :status
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
