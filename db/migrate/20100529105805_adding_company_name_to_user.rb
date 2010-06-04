class AddingCompanyNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company_name, :string
  end

  def self.down
    remove_column :users, :company_name
  end
end
