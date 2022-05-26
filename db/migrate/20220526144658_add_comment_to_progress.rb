class AddCommentToProgress < ActiveRecord::Migration[6.1]
  def change
    add_column :progresses, :comment, :string
  end
end
