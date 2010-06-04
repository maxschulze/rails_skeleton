class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.string :address
      t.string :location
      t.integer :person_id

      t.timestamps
    end
    
    add_index :email_addresses, :person_id
  end

  def self.down
    remove_index :email_addresses, :person_id
    drop_table :email_addresses
  end
end