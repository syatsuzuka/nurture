class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.date :date
      t.float :score
      t.references :target, null: false, foreign_key: true

      t.timestamps
    end
  end
end
