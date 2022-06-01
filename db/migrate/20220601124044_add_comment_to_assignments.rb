class AddCommentToAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :assignments, :review_comment, :text
    add_column :assignments, :material_url, :varchar
  end
end
