class RemoveFirstNaeFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :first_nae
  end

  def down
    add_column :users, :first_nae, :string
  end
end
