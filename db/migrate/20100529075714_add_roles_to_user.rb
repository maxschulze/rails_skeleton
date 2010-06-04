class AddRolesToUser < ActiveRecord::Migration
  
  def self.up
    add_column :users, :role_name, :string
  end

  def self.down
    remove_column :users, :role_name
  end
  
end
