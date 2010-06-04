class AddingProfileAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_name, :string
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :user_name
  end
end
