class DropRolesUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :roles_users
  end
end
