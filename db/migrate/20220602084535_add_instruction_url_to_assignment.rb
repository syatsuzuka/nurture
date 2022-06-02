class AddInstructionUrlToAssignment < ActiveRecord::Migration[6.1]
  def change
    add_column :assignments, :instruction_url, :varchar
  end
end
