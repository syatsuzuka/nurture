class AddPolymorphismToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :likeable_id
    add_column :likes, :likeable_type, :string

    remove_index :likes, [:user_id, :likeable_id]
    #to ensure user can give only one like to any likeable object
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
    #For getting count of likes for a likeable "type" eg. post or comment
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
