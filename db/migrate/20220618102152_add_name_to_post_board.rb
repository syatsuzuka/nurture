class AddNameToPostBoard < ActiveRecord::Migration[6.1]
  def change
    add_column :post_boards, :name, :string
  end
end
