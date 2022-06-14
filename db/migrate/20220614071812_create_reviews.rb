class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :stars, null: false
      t.text :comment
      t.boolean :anonymous, default: false
      t.references :tutor, null: false, foreign_key: { to_table: :users }
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
