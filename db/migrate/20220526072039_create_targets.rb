class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :name
      t.text :description
      t.float :score
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
