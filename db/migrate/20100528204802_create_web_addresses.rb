class CreateWebAddresses < ActiveRecord::Migration
  def self.up
    create_table :web_addresses do |t|
      t.string :url
      t.string :location
      t.integer :person_id

      t.timestamps
    end

    add_index :web_addresses, :person_id
  end

  def self.down
    drop_table :web_addresses
  end
end
