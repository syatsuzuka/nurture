class CreateLikeCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :like_counts do |t|
      t.integer :likes, default: 0
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end