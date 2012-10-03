class AddFirstnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_nae, :string
    add_column :users, :last_name, :string
    add_column :users, :profile_name, :string
  end
end
