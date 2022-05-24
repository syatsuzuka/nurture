class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :string
#Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
